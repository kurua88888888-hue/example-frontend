# Stage 1: Build
FROM node:16 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ENV REACT_APP_BACKEND_URL=https://example-backend-48jt.onrender.com
RUN npm run build

# Stage 2: Runtime
FROM node:16-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/build ./build
EXPOSE 5000
CMD ["serve", "-s", "-l", "5000", "build"]
