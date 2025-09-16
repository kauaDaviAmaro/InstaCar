# Build Flutter web and serve with Nginx

FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

# Enable Flutter web
RUN flutter config --enable-web

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80


