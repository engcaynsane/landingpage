FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["landingpage1/landingpage1.csproj", "landingpage1/"]
RUN dotnet restore "landingpage1/landingpage1.csproj"

COPY . .
WORKDIR /src/landingpage1
RUN dotnet publish "landingpage1.csproj" --configuration Release --output /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
CMD ["sh", "-c", "dotnet landingpage1.dll --urls http://0.0.0.0:${PORT:-8080}"]
