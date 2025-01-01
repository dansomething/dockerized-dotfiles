# Dockerized Dotfiles

This repository contains a Dockerfile to build an Ubuntu Docker image containing
all of my dotfiles. This is useful for quickly demonstrating and testing them.

* [dotfiles](https://github.com/dansomething/dotfiles)
* [dot_vim](https://github.com/dansomething/dot_vim)

## Building the image

To build the image, run the following command:

```bash
docker build --rm -t dotfiles:latest .
```

## Running the container

To run the container, run the following command:

```bash
docker run -it --rm dotfiles:latest
```
