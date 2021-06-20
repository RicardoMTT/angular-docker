# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:10-alpine as build-step

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY package.json /app

# Install all the dependencies
RUN npm install

# Generate the build of the application
COPY . /app

# Stage 2: Serve app with nginx server
RUN npm run build --prod
# Use official nginx image as the base image
FROM nginx:1.17.1-alpine

# Copy the build output to replace the default nginx contents.
COPY --from=build-step /app/dist/angular-docker /usr/share/nginx/html
# Expose port 80
EXPOSE 80
