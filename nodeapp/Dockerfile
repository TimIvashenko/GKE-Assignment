# Use an official Node.js runtime as your parent image
FROM node:lts-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install any dependencies
RUN npm install

# Bundle your app's source code inside the Docker image
COPY . .

# Make your app's port available to the outside world
EXPOSE 3000

# Define the command to run your app
CMD [ "node", "nodeapp.js" ]
