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

## Related projects

### [Wowchemy](https://github.com/wowchemy/wowchemy-hugo-modules)

[Wowchemy theme](https://wowchemy.com/) for [Hugo](https://gohugo.io/).