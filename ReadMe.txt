Plik Dockerfile jest podzielony na dwie części: pierwsza (build) służy do kompilacji i przygotowania aplikacji, a druga (runtime) do uruchomienia jej w kontenerze produkcyjnym. Dzięki temu rozdzieleniu możliwe jest tworzenie mniejszych i bardziej zoptymalizowanych obrazów kontenerowych.

Aby zbudować i uruchomić kontener z obrazem opisanym w pliku Dockerfile, wykonaj następujące kroki:

1. Wykonaj polecenie docker build, aby zbudować obraz.Polecenie to przyjmuje dwa argumenty: -t (tag) i ścieżkę do katalogu, w którym znajduje się plik Dockerfile:

docker build -t my-dotnet-app:latest .

2. Po zbudowaniu obrazu możesz uruchomić kontener, korzystając z polecenia docker run:

docker run -p 8080:8080 my-dotnet-app:latest .

3. Twoja aplikacja powinna być teraz uruchomiona w kontenerze. Możesz otworzyć przeglądarkę i przejść pod adres:

http://localhost:8080/swagger/index.html