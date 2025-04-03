# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy dependency file first for better caching
COPY requirements.txt /app/requirements.txt

# Install build dependencies (optional, if needed for packages like psycopg2)
RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application source code
COPY . /app

# Copy the wait-for-db script and ensure it has execute permissions
COPY wait-for-db.sh /wait-for-db.sh
RUN chmod +x /wait-for-db.sh

# Expose the application port
EXPOSE 8000

# Command to wait for the database and start the application
CMD ["#!/bin/bash", "-c", "/wait-for-db.sh && uvicorn src.main:app --host 0.0.0.0 --port 8000"]
