#!/bin/bash

# Start docker containers
echo "Starting database containers..."
docker-compose up -d

# Wait for databases to be ready
echo "Waiting for databases to initialize..."
sleep 30

# Install Python dependencies
pip install -r scripts/python/requirements.txt

# Run data distribution
echo "Distributing data across fragments..."
python scripts/python/distribute_data.py

echo "Fragmentation complete!"

