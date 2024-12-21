FROM cirrusci/flutter:latest

# Dodanie użytkownika
RUN adduser --disabled-password --gecos "" flutteruser
RUN chown -R flutteruser:flutteruser /sdks/flutter
USER flutteruser

# RUN flutter upgrade

# Ustawienia projektu Flutter
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
# RUN flutter pub get

# Kopiowanie reszty kodu
COPY . ./
# RUN chown -R flutteruser:flutteruser /app







