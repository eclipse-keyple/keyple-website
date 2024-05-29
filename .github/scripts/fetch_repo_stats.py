import csv
import requests
import argparse
from datetime import datetime
from time import sleep
import os
import re

def rate_limited_get(url, headers):
    print(f'Fetching URL: {url}')
    while True:
        response = requests.get(url, headers=headers)
        if response.status_code == 403 and 'X-RateLimit-Reset' in response.headers:
            reset_time = int(response.headers.get('X-RateLimit-Reset'))
            current_time = datetime.now().timestamp()
            sleep_time = reset_time - current_time
            if sleep_time > 0:
                print(f'Rate limit exceeded. Sleeping for {sleep_time} seconds.')
                sleep(sleep_time + 1)
                continue
        if response.status_code >= 400:
            print(f'Error {response.status_code}: {response.json()}')
        response.raise_for_status()
        return response

def get_repo_creation_date(owner, repo, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}'
    print(f'Calling get_repo_creation_date with URL: {url}')
    response = rate_limited_get(url, headers)
    repo_info = response.json()
    creation_date = datetime.strptime(repo_info['created_at'], '%Y-%m-%dT%H:%M:%SZ')
    print(f'Repo created at: {creation_date}')
    return creation_date

def get_releases(owner, repo, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}/releases'
    print(f'Calling get_releases with URL: {url}')
    response = rate_limited_get(url, headers)
    releases = response.json()
    return sorted(releases, key=lambda x: datetime.strptime(x['created_at'], '%Y-%m-%dT%H:%M:%SZ'))

def classify_release(release, max_major, max_minors, max_patches, latest_releases):
    tag_name = release['tag_name']
    major, minor, patch = map(int, tag_name.lstrip('v').split('.'))

    print(f'Processing release: {tag_name} (created at {release["created_at"]})')

    patches = minors = majors = 0

    if major > max_major:
        print(f'Incrementing majors counter: {majors + 1}')
        majors += 1
        max_major = major
        max_minors[major] = minor
        max_patches[(major, minor)] = patch
    elif major <= max_major:
        if minor > max_minors.get(major, 0):
            print(f'Incrementing minors counter: {minors + 1}')
            minors += 1
            max_minors[major] = minor
            max_patches[(major, minor)] = patch
        elif minor <= max_minors[major] and patch > max_patches.get((major, minor), 0):
            print(f'Incrementing patches counter: {patches + 1}')
            patches += 1
            max_patches[(major, minor)] = patch

    latest_releases[major] = tag_name

    return majors, minors, patches, max_major, max_minors, max_patches, latest_releases, tag_name

def get_lines_added_and_deleted_from_diff(owner, repo, headers, base, head):
    url = f'https://api.github.com/repos/{owner}/{repo}/compare/{base}...{head}'
    print(f'Calling get_lines_added_and_deleted_from_diff with URL: {url}')
    headers['Accept'] = 'application/vnd.github.diff'
    response = rate_limited_get(url, headers)

    diff_text = response.text

    lines_added = 0
    lines_deleted = 0

    for line in diff_text.splitlines():
        if line.startswith('+') and not line.startswith('+++'):
            lines_added += 1
        elif line.startswith('-') and not line.startswith('---'):
            lines_deleted += 1

    return lines_added, lines_deleted

def get_stats_per_release(owner, repo, repo_name, headers, initial_lines, output_dir):
    creation_date = get_repo_creation_date(owner, repo, headers)
    releases = get_releases(owner, repo, headers)
    main_stats = []
    hotfix_stats = {}

    max_major = 0
    max_minors = {}
    max_patches = {}
    latest_releases = {}

    total_lines = initial_lines
    cumulative_lines_added = 0
    cumulative_lines_deleted = 0

    cumulative_majors = 0
    cumulative_minors = 0
    cumulative_patches = 0

    previous_tag = None
    previous_stat = None

    last_minor_release = {}

    for release in releases:
        current_tag = release['tag_name']

        if not re.match(r'^v?\d+\.\d+\.\d+$', current_tag):  # Match tags of type x.y.z or vx.y.z
            print(f'Ignoring invalid tag: {current_tag}')
            continue

        release_date = datetime.strptime(release['created_at'], '%Y-%m-%dT%H:%M:%SZ')
        current_major = int(current_tag.lstrip('v').split('.')[0])

        if previous_tag is None:
            majors, minors, patches, max_major, max_minors, max_patches, latest_releases, _ = classify_release(release, max_major, max_minors, max_patches, latest_releases)
            cumulative_majors += majors
            cumulative_minors += minors
            cumulative_patches += patches
            stat = {
                'date': release_date.strftime('%Y-%m-%d'),
                'version_tag': current_tag,
                'total_lines': total_lines,
                'lines_added': 0,
                'lines_deleted': 0,
                'majors': cumulative_majors,
                'minors': cumulative_minors,
                'patches': cumulative_patches
            }
            print(f'Stat for first release on {release_date.strftime("%Y-%m-%d")}: {stat}')
            main_stats.append(stat)
        else:
            if current_major in latest_releases:
                previous_tag = latest_releases[current_major]
            lines_added, lines_deleted = get_lines_added_and_deleted_from_diff(owner, repo, headers, previous_tag, current_tag)
            cumulative_lines_added += lines_added
            cumulative_lines_deleted += lines_deleted

            print(f'For release {release["tag_name"]} on {release_date.strftime("%Y-%m-%d")}:')
            print(f'  Lines added: {lines_added}')
            print(f'  Lines deleted: {lines_deleted}')

            majors, minors, patches, max_major, max_minors, max_patches, latest_releases, _ = classify_release(release, max_major, max_minors, max_patches, latest_releases)

            cumulative_majors += majors
            cumulative_minors += minors
            cumulative_patches += patches

            total_lines += cumulative_lines_added - cumulative_lines_deleted

            stat = {
                'date': release_date.strftime('%Y-%m-%d'),
                'version_tag': current_tag,
                'total_lines': total_lines,
                'lines_added': cumulative_lines_added,
                'lines_deleted': cumulative_lines_deleted,
                'majors': cumulative_majors,
                'minors': cumulative_minors,
                'patches': cumulative_patches
            }
            print(f'Stat for release on {release_date.strftime("%Y-%m-%d")}: {stat}')

            if current_major < max_major:
                hotfix_filename = f'{repo_name}-hotfixes-{current_major}.csv'
                if hotfix_filename not in hotfix_stats:
                    hotfix_stats[hotfix_filename] = []
                    # Find the last release of this lineage
                    if current_major in last_minor_release:
                        last_release = last_minor_release[current_major]
                        hotfix_stats[hotfix_filename].append(last_release)
                        # Update the total lines to start from the last release of this lineage
                        lineage_total_lines = last_release['total_lines']
                else:
                    # Use the last known total lines if lineage has already been processed
                    lineage_total_lines = hotfix_stats[hotfix_filename][-1]['total_lines']
                # Adjust the total lines for this stat in the hotfix file
                stat['total_lines'] = lineage_total_lines + stat['lines_added'] - stat['lines_deleted']
                hotfix_stats[hotfix_filename].append(stat)
            else:
                main_stats.append(stat)
                last_minor_release[current_major] = stat

            cumulative_lines_added = 0
            cumulative_lines_deleted = 0

        previous_tag = current_tag
        previous_stat = stat

    return main_stats, hotfix_stats

def write_csv(filename, stats, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    abs_path = os.path.abspath(os.path.join(output_dir, filename))
    with open(abs_path, 'w', newline='') as csvfile:
        fieldnames = ['date', 'version_tag', 'total_lines', 'lines_added', 'lines_deleted', 'majors', 'minors', 'patches']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for stat in stats:
            writer.writerow(stat)

    print(f'CSV file {abs_path} created successfully!')

def process_repo(repo_owner, repo_name, initial_lines, headers, output_dir, files_list):
    print(f'Starting data extraction for repo {repo_owner}/{repo_name}')
    try:
        main_stats, hotfix_stats = get_stats_per_release(repo_owner, repo_name, repo_name, headers, initial_lines, output_dir)
        main_file = f'{repo_name}.csv'
        write_csv(main_file, main_stats, output_dir)
        files_list.append(f'{repo_owner}/{repo_name}')
        for hotfix_filename, stats in hotfix_stats.items():
            write_csv(hotfix_filename, stats, output_dir)
            hotfix_repo_name = f'{repo_owner}/{repo_name}-hotfixes-{hotfix_filename.split("-")[-1].replace(".csv", "")}'
            files_list.append(hotfix_repo_name)
        print(f'Process completed for {repo_owner}/{repo_name}.')
    except requests.exceptions.RequestException as e:
        print(f'Error processing repo {repo_owner}/{repo_name}: {e}')

def write_files_list(files_list, output_dir):
    stats_files_path = os.path.abspath(os.path.join(output_dir, 'stats_files'))
    with open(stats_files_path, 'w') as file:
        for filename in files_list:
            file.write(f'{filename}\n')
    print(f'File {stats_files_path} created successfully!')

def main():
    parser = argparse.ArgumentParser(description='Process GitHub repository statistics from a file.')
    parser.add_argument('input_file', type=str, help='The input file containing GitHub repositories (one per line)')
    parser.add_argument('--token', type=str, required=True, help='The GitHub token for authentication')
    parser.add_argument('--output-dir', type=str, required=True, help='The directory to output CSV files')

    args = parser.parse_args()

    headers = {
        'Authorization': f'token {args.token}',
        'Accept': 'application/vnd.github.v3+json'
    }

    files_list = []

    with open(args.input_file, 'r') as file:
        repos = file.readlines()

    for repo in repos:
        repo = repo.strip()
        if repo:
            parts = repo.split()
            repo_owner, repo_name = parts[0].split('/')
            initial_lines = int(parts[1])
            process_repo(repo_owner, repo_name, initial_lines, headers, args.output_dir, files_list)

    write_files_list(files_list, args.output_dir)

if __name__ == "__main__":
    main()