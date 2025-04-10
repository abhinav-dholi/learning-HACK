# Dockerfile
FROM hhvm/hhvm:latest

# Create app folder
WORKDIR /app

# Copy local files into container
COPY . /app

# Default command to run Hack files
CMD ["hhvm", "hello.hack"]