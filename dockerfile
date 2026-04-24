FROM node:20-alpine3.20 AS builder # Use a specific version of Node.js on Alpine Linux for the build stage, this helps to ensure that the build environment is consistent and optimized for building Node.js applications, resulting in smaller image sizes and faster build times compared to using a full Node.js image.
WORKDIR /opt/server # Set the working directory for the build stage, this is where the application code will be copied and where the npm install command will be executed to install the application dependencies.
COPY package.json .  # Copy the package.json file to the working directory, this file contains the metadata and dependencies for the Node.js application, it is necessary for running npm install to install the required packages.
COPY *.js . # Copy all JavaScript files to the working directory, this includes the application code that will be executed when the container runs, it is important to ensure that all necessary files are copied to the build stage for a successful build.
RUN npm install  # Run the npm install command to install the application dependencies defined in the package.json file, this will create a node_modules directory with all the required packages for the application to run.

FROM node:20-alpine3.20
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN apk update && apk add --no-cache --upgrade musl openssl
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node","server.js"]


# FROM node:20-alpine3.21
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# RUN npm install
# RUN chown -R roboshop:roboshop /opt/server
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# USER roboshop
# CMD ["node","server.js"]