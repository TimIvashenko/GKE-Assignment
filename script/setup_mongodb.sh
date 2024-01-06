#!/bin/bash
# Install necessary packages for adding a new repository
sudo apt-get update
sudo apt-get install -y gnupg curl

# Add the MongoDB GPG key
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

# Add the MongoDB repository
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Update the package list
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org

# Update MongoDB configuration
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
echo "replication:" | sudo tee -a /etc/mongod.conf
echo "  replSetName: \"rs0\"" | sudo tee -a /etc/mongod.conf

# Start and enable MongoDB service
sudo systemctl start mongod
sudo systemctl enable mongod

# Check if the node is mongodb-node1 and initiate replica set if it is
if [ "$(hostname)" = "mongodb-node1" ]; then
    # Wait for MongoDB to start
    sleep 15
    # Initiate replica set
    mongosh --eval 'rs.initiate({_id: "rs0", members: [{_id: 0, host: "10.0.1.2:27017"}, {_id: 1, host: "10.0.1.3:27017"}, {_id: 2, host: "10.0.1.4:27017", arbiterOnly: true}]});'
fi
