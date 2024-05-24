import csv
import requests
import argparse
from datetime import datetime, timedelta
from time import sleep
import os

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

def get_commit_activity(owner, repo, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}/stats/code_frequency?ref=main'
    print(f'Calling get_commit_activity with URL: {url}')
    response = rate_limited_get(url, headers)
    commit_activity = response.json()
    print(f'Commit activity retrieved: {len(commit_activity)} weeks')
    return commit_activity

def get_releases(owner, repo, headers):
    url = f'https://api.github.com/repos/{owner}/{repo}/releases'
    print(f'Calling get_releases with URL: {url}')
    response = rate_limited_get(url, headers)
    releases = response.json()
    return sorted(releases, key=lambda x: datetime.strptime(x['created_at'], '%Y-%m-%dT%H:%M:%SZ'))

def classify_release(release, max_major, max_minors, max_patches):
    tag_name = release['tag_name']
    try:
        major, minor, patch = map(int, tag_name.lstrip('v').split('.'))
    except ValueError:
        print(f'Skipping invalid tag: {tag_name}')
        return 0, 0, 0, max_major, max_minors, max_patches, '0.0.0'

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

    return majors, minors, patches, max_major, max_minors, max_patches, tag_name

def get_stats_per_release(owner, repo, headers, initial_lines):
    creation_date = get_repo_creation_date(owner, repo, headers)
    releases = get_releases(owner, repo, headers)
    commit_activity = get_commit_activity(owner, repo, headers)
    stats = []

    # Initialize cumulative release counts and starting version
    cumulative_majors = cumulative_minors = cumulative_patches = 0
    max_major = 0
    max_minors = {}
    max_patches = {}

    # Initialize the previous release date and commit counters
    previous_release_date = creation_date
    total_lines = initial_lines
    first_release_reached = False

    # Initialize variables for cumul of lines added and deleted
    cumulative_lines_added = 0
    cumulative_lines_deleted = 0

    for release in releases:
        release_date = datetime.strptime(release['created_at'], '%Y-%m-%dT%H:%M:%SZ')

        # Find commits up to the release date and calculate differences
        lines_added = sum(week[1] for week in commit_activity if previous_release_date <= datetime.utcfromtimestamp(week[0]) < release_date)
        lines_deleted = sum(-week[2] for week in commit_activity if previous_release_date <= datetime.utcfromtimestamp(week[0]) < release_date)

        # Update cumulative lines added and deleted
        cumulative_lines_added += lines_added
        cumulative_lines_deleted += lines_deleted

        print(f'For release {release["tag_name"]} on {release_date.strftime("%Y-%m-%d")}:')
        print(f'  Previous release date: {previous_release_date.strftime("%Y-%m-%d")}')
        print(f'  Lines added: {lines_added}')
        print(f'  Lines deleted: {lines_deleted}')

        # Update the previous release date
        previous_release_date = release_date

        majors, minors, patches, max_major, max_minors, max_patches, current_tag = classify_release(release, max_major, max_minors, max_patches)

        # Update cumulative release counts
        cumulative_majors += majors
        cumulative_minors += minors
        cumulative_patches += patches

        if first_release_reached:
            # Update total lines
            total_lines += cumulative_lines_added - cumulative_lines_deleted

        if current_tag != '0.0.0':
            # If the first release is reached, calculate total lines for the first release
            if not first_release_reached:
                cumulative_lines_added = cumulative_lines_deleted = 0
                total_lines = initial_lines
                first_release_reached = True

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
            stats.append(stat)

            # Reset cumulative lines added and deleted
            cumulative_lines_added = 0
            cumulative_lines_deleted = 0

    return stats

def write_csv(repo_name, stats, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    filename = os.path.join(output_dir, f'{repo_name}.csv')
    abs_path = os.path.abspath(filename)
    with open(filename, 'w', newline='') as csvfile:
        fieldnames = ['date', 'version_tag', 'total_lines', 'lines_added', 'lines_deleted', 'majors', 'minors', 'patches']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for stat in stats:
            writer.writerow(stat)

    print(f'CSV file {abs_path} created successfully!')

def process_repo(repo_owner, repo_name, initial_lines, headers, output_dir):
    print(f'Starting data extraction for repo {repo_owner}/{repo_name}')
    try:
        stats = get_stats_per_release(repo_owner, repo_name, headers, initial_lines)
        write_csv(repo_name, stats, output_dir)
        print(f'Process completed for {repo_owner}/{repo_name}.')
    except requests.exceptions.RequestException as e:
        print(f'Error processing repo {repo_owner}/{repo_name}: {e}')

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

    with open(args.input_file, 'r') as file:
        repos = file.readlines()

    for repo in repos:
        repo = repo.strip()
        if repo:
            parts = repo.split()
            repo_owner, repo_name = parts[0].split('/')
            initial_lines = int(parts[1])
            process_repo(repo_owner, repo_name, initial_lines, headers, args.output_dir)

if __name__ == "__main__":
    main()
