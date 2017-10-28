FROM ubuntu:16.04

# Install system dependencies
RUN apt-get update && apt install -y wget curl apt-utils

# Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Chrome
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

# Install dependencies
RUN apt-get update && apt-get install -fy nodejs imagemagick xvfb google-chrome-stable
RUN rm -rf /var/cache/apt/archives/*
