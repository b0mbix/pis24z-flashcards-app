FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  xz-utils \
  zip \
  libglu1-mesa \
  bash

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /sdks/flutter

# Set the environment variable for Flutter
ENV PATH="/sdks/flutter/bin:${PATH}"

# Verify Flutter installation
RUN flutter doctor

# Add a user for running Flutter
RUN adduser --disabled-password --gecos "" flutteruser
RUN chown -R flutteruser:flutteruser /sdks/flutter
USER flutteruser

# Set the working directory to the Flutter project
WORKDIR /app/flashcards

# Copy the Flutter project definition files as flutteruser
COPY --chown=flutteruser:flutteruser flashcards/pubspec.yaml flashcards/pubspec.lock ./

# Run flutter doctor to ensure everything is set up
RUN flutter doctor || true

# Get the Flutter dependencies
RUN flutter pub get

# Switch to the stable channel and upgrade Flutter
RUN flutter channel stable && flutter upgrade

# Copy the rest of the project files as flutteruser
COPY --chown=flutteruser:flutteruser flashcards/ ./

# Ensure proper permissions for the application directory
RUN chmod -R u+rw /app/flashcards

