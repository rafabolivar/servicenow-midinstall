# Servicenow MID Server Scripted Installation on Ubuntu Server
This is an easy way to automate your Servicenow MID Server installation and validation on Ubuntu. If you want to learn more about Servicenow MID Server, please refer to [the official documentation](https://docs.servicenow.com/bundle/utah-servicenow-platform/page/product/mid-server/concept/mid-server-landing.html). 

## Prerequisites

Before starting the installation, you'll need to deploy an Ubuntu Server. I recommend using an official [Ubuntu Cloud Image](https://cloud-images.ubuntu.com/), since it's a quick way to deploy virtual machines in a matter of minutes, avoiding to manage a full installation by yourself. Probably, the full how-to works for Debian as well, although I haven't tested it.

The other prerequisite you need is a working Servicenow instance. It can be a Demohub instance. 

## Installing your MID Server

Once your Ubuntu Server is running, connect via SSH and clone our repository by using the `git` command:
