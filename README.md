docker-jekyll
====
Just a small image to generate a jekyll blog 

### Create a new blog
Following is a simple command to create a new blog in a directory.
The `:z` at the volume mount part is only required when running a distro with SELinux active.

```
 podman run -v $(pwd):/site:z ghcr.io/deb4sh/docker-jekyll:sha-6da81e9 new .
```

