# Use Python Alpine as base image
FROM python:3.9-alpine

# Install build dependencies required for some Python packages
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Remove build dependencies to keep the image slim
RUN apk del gcc musl-dev python3-dev

# Copy the application code
COPY main.py .

# Expose the port the app runs on
EXPOSE 8090

# Command to run the application
CMD ["python", "main.py"]