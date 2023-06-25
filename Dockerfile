FROM node:19 AS spifyui
WORKDIR /ui
COPY spify/ ./
RUN npm install && npm run build

FROM node:19 AS spifyserver
WORKDIR /app
COPY spify-server/ ./
COPY serverconfig.json ./config.json
RUN npm install --production
COPY --from=spifyui /ui/build ./public

EXPOSE 3001
CMD ["node", "./spifyweb-server.js"]