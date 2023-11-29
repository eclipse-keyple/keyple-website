# Eclipse Keyple website  

Repository to the www.keyple.org website of the 'Eclipse Keyple' project.

The Eclipse Keyple website is generated with Hugo.

## Getting started

### Local installation
Install [hugo extended](https://gohugo.io/getting-started/installing/) on your machine.
Install dependencies, build assets and start a webserver:
```bash
hugo server
```

Checkout http://localhost:1313/

### Using docker 

You can use the image "ext-alpine" from the project : https://github.com/klakegg/docker-hugo. An "ext" is needed image because it includes golang.


Launch a shell into hugo container from the root directory of this project
```bash
docker run --rm -it \
  -v $(pwd):/src \
    -p 1313:1313 \
  klakegg/hugo:ext-alpine \
  shell
```

Then run
```bash
hugo server --environment development
```

If you want to avoid downloading modules at each run, install them locally by running
```bash
hugo mod vendor
```

## Custom Front Matter Parameters

### `sitemap_exclude`

- **Purpose**: The `sitemap_exclude` parameter is used to control the inclusion of individual pages in the site's 
`sitemap.xml`. This is particularly useful for pages that we do not want to be easily discoverable by search engines 
or listed in the sitemap.
- **Usage**: Set `sitemap_exclude: true` in the front matter of any page we wish to exclude from the `sitemap.xml`.
- **Example**:
  ```yaml
  ---
  title: "Example Page"
  sitemap_exclude: true
  ---

### `robots`
- **Purpose**: The `robots` parameter allows us to specify the value for the `<meta name="robots">` tag on a per-page 
basis. This tag provides instructions to web crawlers (like Googlebot) about whether they should index the page, 
follow links on it, or both.
- **Usage**: Set `robots` to a string value indicating the desired directive, such as "noindex, nofollow" to both 
prevent indexing of the page and following of its links.
- **Example**:
  ```yaml
    ---
    title: "Private Page"
    robots: "noindex, nofollow"
    ---

## Related projects

### [Wowchemy](https://github.com/wowchemy/wowchemy-hugo-modules)

[Wowchemy theme](https://wowchemy.com/) for [Hugo](https://gohugo.io/).