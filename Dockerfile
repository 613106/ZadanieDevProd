# Użycie oficjalnego ostatnie wydanie obrazu Linuxa jako bazowego obrazu:
FROM ubuntu:latest AS build

# Aktualizacja i instalacja narzędzi, w tym .NET 6.0 SDK:
RUN apt-get update && apt-get install -y wget apt-transport-https gpg \
    && apt-get update && apt-get install -y ca-certificates \
    && apt-get update && apt-get install -y dotnet-sdk-6.0

# Ustawienie katalogu roboczego:
WORKDIR /app

# Kopiowanie plików do kontenera:
COPY . .

# Przywracanie zależności projektu .NET:
RUN dotnet restore

# Kopiowanie kodu źródłowego aplikacji i publikacja:
COPY ZadanieDevProd .
RUN dotnet publish -c Debug -o /src

# Tworzenie drugiego obrazu:
FROM ubuntu:latest AS runtime

# Instalacja aspnetcore-runtime-6.0:
RUN apt-get update && apt-get install -y aspnetcore-runtime-6.0

# Ustawienie katalogu roboczego:
WORKDIR /app

# Kopiowanie plików z poprzedniego etapu (z obrazu "build"):
COPY --from=build /src .

# Eksponowanie portu 8080:
EXPOSE 8080

# Konfiguracja zmiennych środowiskowych:
ENV ASPNETCORE_URLS=http://+:8080

# Uruchomienie aplikacji po starcie kontenera
ENTRYPOINT ["dotnet", "ZadanieDevProd.dll", "--environment=Development"]