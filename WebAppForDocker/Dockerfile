FROM microsoft/dotnet:2.2-sdk AS build

LABEL MAINTAINER=klas.persson.signell@cygni.se

WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build /app/out .

HEALTHCHECK CMD curl -f http://localhost/healthz

ENV APP_NAME=KlasTest
EXPOSE 80

ENTRYPOINT ["dotnet", "WebAppForDocker.dll"]