# Użycie oficjalnego obrazu z Ubuntu jako bazowego
FROM ubuntu:22.04

# Instalacja niezbędnych pakietów systemowych, w tym certyfikatów SSL
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl git unzip xz-utils zip libglu1-mesa ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalacja Fluttera
RUN mkdir -p /sdks \
    && curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.7-stable.tar.xz \
    && tar -xf flutter.tar.xz -C /sdks \
    && rm flutter.tar.xz

ENV PATH="/sdks/flutter/bin:/sdks/flutter/bin/cache/dart-sdk/bin:$PATH"

# Dodanie katalogu Flutter do bezpiecznych katalogów git
RUN git config --global --add safe.directory /sdks/flutter

# Wymuszenie aktualizacji wersji Fluttera i Dart SDK
RUN /sdks/flutter/bin/flutter upgrade \
    && /sdks/flutter/bin/flutter doctor -v

# Dodanie użytkownika bez uprawnień administratora
RUN adduser --disabled-password --gecos "" flutteruser \
    && chown -R flutteruser:flutteruser /sdks/flutter

# Ustawienie katalogu roboczego
WORKDIR /app

# Tworzenie katalogu /app
RUN mkdir -p /app

# Kopiowanie plików zależności projektu
COPY pubspec.yaml pubspec.lock ./

# Wykonanie polecenia 'flutter pub get' bez zmiany właściciela
RUN flutter pub get || true

# Kopiowanie reszty plików projektu
COPY . ./

# Budowanie aplikacji
RUN flutter build web

# Punkt wejścia dla kontenera
CMD ["flutter", "run", "--web-server"]