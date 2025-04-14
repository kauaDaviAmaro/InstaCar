FROM cirrusci/flutter:stable

# Set working directory
WORKDIR /app

# Copy the Flutter project files
COPY . .

# Install dependencies
RUN flutter pub get

# Expose the web server port
EXPOSE 8080

# Run the Flutter web server
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0"]