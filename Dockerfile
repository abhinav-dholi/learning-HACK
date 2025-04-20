FROM hhvm/hhvm:latest

# Create app folder
WORKDIR /app

# Copy local files into container
COPY . /app

# Set default command to shell so we can run files manually
CMD ["/bin/bash"]