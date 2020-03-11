## Biome-Shiny Docker Image

### Introduction

This is a Docker image for the [Biome-Shiny microbiome visualization tool](https://github.com/BioData-PT/Biome-Shiny), created to simplify and speed up the deployment of this tool across several machines.
The image, based on Ubuntu 18.04, will provide the user with all the dependencies necessary to run the Biome-Shiny application, thus making it an ideal way to distribute the tool in a work or education environment.

### Installation

You will first need to install Docker for your machine. For this, please follow the instructions in the [Docker documentation website](https://docs.docker.com).

Once Docker is installed on your machine, to pull the latest version of the Biome-Shiny docker image, all you need to do is type the following command into your terminal:

```sh
docker pull hmcs/biome-shiny-docker:latest
```

### Running a Biome-Shiny session

Once the image is downloaded, you can create a new container by running the following command:

```sh
docker start -p 3838:3838 hmcs/biome-shiny-docker:latest
```
This will start a local Shiny Server session on your machine, running Biome-Shiny. To open it, type `localhost:3838` on your web browser of choice.

**Note for Docker Toolbox users:** If you are using Docker Toolbox, the session you have started from your terminal will not be hosted on localhost. You will instead need to connect to the virtual machine generated by Docker Quickstart. You can obtain the machine's IP with the `docker-machine ip` command, or from the first line in the terminal, e.g.: `docker is configured to use the default machine with IP 192.168.99.100`.
