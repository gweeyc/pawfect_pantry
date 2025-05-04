FROM node:18

WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json ./

# Install all dependencies (including cross-env)
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the app
RUN npm run build

# Start the app (optional if you're using Nginx or serve later)
CMD ["npm", "start"]



