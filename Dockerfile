FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:18-slim

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/dist ./dist

RUN npm install --omit=dev

ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "dist/index.js"]
