FROM dart:3.1.0

WORKDIR /app

COPY . .

RUN dart pub get

RUN dart compile exe bin/main.dart -o server

EXPOSE 4401

CMD [ "/app/server" ]