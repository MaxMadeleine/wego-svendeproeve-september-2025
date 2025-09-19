# Use a Node.js base image
FROM node:22-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .

# Run Prisma migrations and seed the database
# Make sure to set your DATABASE_URL as an environment variable in Render
RUN npx prisma migrate deploy
RUN npm run seed

# Build the TypeScript application
RUN npm run build

# Expose the port your app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
