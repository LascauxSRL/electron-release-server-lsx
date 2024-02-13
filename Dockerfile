FROM node:19

# Create app directory
WORKDIR /usr/src/electron-release-server

# Install app dependencies
COPY package.json .bowerrc bower.json /usr/src/electron-release-server/
RUN npm install \
  && ./node_modules/.bin/bower install --allow-root \
  && npm cache clean --force \
  && npm prune --production

RUN apt-get update && apt-get install -y dos2unix

# Bundle app source
COPY . /usr/src/electron-release-server
COPY config/docker.js config/local.js

RUN dos2unix ./scripts/wait.sh

EXPOSE 80

CMD [ "npm", "start" ]
