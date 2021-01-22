FROM node:latest

# Add application sources
ADD . .

# Install the dependencies
RUN npm install

# Run script uses standard ways to run the application
CMD npm run dev -d
