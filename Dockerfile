FROM node:16

EXPOSE 3001 3005

WORKDIR /shapez.io

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg default-jre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

COPY package.json yarn.lock ./
RUN yarn

COPY gulp ./gulp
WORKDIR /shapez.io/gulp
RUN yarn

WORKDIR /shapez.io
COPY res ./res
COPY src/html ./src/html
COPY src/css ./src/css
COPY version ./version
COPY sync-translations.js ./
COPY translations ./translations
COPY src/js ./src/js
COPY g ./.git
COPY res_raw ./res_raw
COPY electron ./electron

WORKDIR /shapez.io/gulp
ENTRYPOINT ["yarn", "gulp"]
