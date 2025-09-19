# Use a Node.js base image
FROM node:22-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Copy Prisma schema and migrations needed for `prisma generate` during npm install
# and later for `migrate deploy` and `seed`
COPY prisma ./prisma

# Install dependencies, which will run `prisma generate`
RUN npm install

# Copy the rest of your application code
COPY . .

# Run Prisma migrations and seed the database
RUN npx prisma migrate deploy
RUN npm run seed

# Build the TypeScript application
RUN npm run build

# Expose the port your app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
