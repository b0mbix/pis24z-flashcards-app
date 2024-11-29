#!/bin/bash

# Czekamy na pełne uruchomienie Nexusa i wygenerowanie pliku admin.password
while [ ! -f /nexus-data/admin.password ]; do
    echo "Czekam na wygenerowanie pliku admin.password..."
    sleep 5
done

ADMIN_PASSWORD=$(cat /opt/sonatype/nexus-data/admin.password)
echo "Hasło administratora odczytane: $ADMIN_PASSWORD"

# Czekamy, aż Nexus będzie dostępny na porcie 8081
until $(curl --output /dev/null --silent --head --fail http://localhost:8081/service/rest/v1/status); do
    echo "Czekam na uruchomienie Nexusa..."
    sleep 5
done

# Załaduj skrypt Groovy do Nexusa
curl -X POST -u admin:"$ADMIN_PASSWORD" \
    -H "Content-Type: application/json" \
    -d '{
          "name": "init",
          "type": "groovy",
          "content": "'"$(cat /opt/sonatype/nexus/nexus-data/etc/scripts/init.groovy | jq -Rs .)"'"
        }' \
    http://localhost:8081/service/rest/v1/script

# Uruchom załadowany skrypt
curl -X POST -u admin:"$ADMIN_PASSWORD" \
    http://localhost:8081/service/rest/v1/script/init/run


