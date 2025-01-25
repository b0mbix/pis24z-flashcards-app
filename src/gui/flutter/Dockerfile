# Use a compatible Flutter version
FROM instrumentisto/flutter:latest AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Flutter app source code to the container
COPY . /app

# Enable Flutter web
RUN flutter config --enable-web

# Fetch dependencies and build the Flutter web app
RUN flutter pub get
RUN flutter build web

# # Use an Nginx base image to serve the web app
# FROM nginx:stable-alpine

# # Copy the built Flutter web app to the Nginx HTML directory
# COPY --from=build /app/build/web/ /usr/share/nginx/html/

# # Expose port 80 for web traffic
# EXPOSE 8083

# Start Nginx when the container launches
CMD ["flutter", "run", "-d", "web-server", "--web-hostname=0.0.0.0", "--web-port=8083"]
