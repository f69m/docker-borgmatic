# borgmatic Container

![](https://github.com/witten/borgmatic/raw/main/docs/static/borgmatic.png)

## Description ##

This repository provides a Docker image for [borgmatic](https://github.com/witten/borgmatic), a simple and efficient backup tool based on [Borgbackup](https://github.com/borgbackup). The image is designed to make it easy to set up and run borgmatic (with Borg) within a Docker container, enabling you to streamline your backup process and ensure the safety of your data.

This is a fork of https://github.com/borgmatic-collective/docker-borgmatic removing all the clutter I don't need:
  - cron
  - s6 overlay
  - spammy console output
  - notifications

All I need is a container with borgmatic that I can run from a system cron job.
