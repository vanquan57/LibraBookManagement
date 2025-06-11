# Use the official Node.js LTS Alpine image as the base for the build stage
FROM node:lts-alpine as build-stage
# set the working directory
WORKDIR /app

# Copy the working directory in the container
COPY /LibraManager/package*.json ./

# Expose the port that Vite dev server usually runs on
EXPOSE 5173

# Start the development server with hot reloading
CMD ["sh", "-c", "npm install && npm run dev"]
