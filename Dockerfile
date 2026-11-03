# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build
ARG TARGETARCH
ARG VERSION=0.0.0-dev
WORKDIR /src

COPY src/global.json src/Directory.Build.props src/Directory.Packages.props ./
COPY src/ProjectName/ProjectName.csproj ProjectName/
COPY src/ProjectName.Core/ProjectName.Core.csproj ProjectName.Core/
COPY src/ProjectName.Messages/ProjectName.Messages.csproj ProjectName.Messages/
RUN dotnet restore ProjectName/ProjectName.csproj -a ${TARGETARCH}

COPY src/ .
RUN dotnet publish ProjectName/ProjectName.csproj -c Release -a ${TARGETARCH} -o /app /p:Version=${VERSION} /p:ContinuousIntegrationBuild=true

FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine
ARG VERSION=0.0.0-dev
LABEL org.opencontainers.image.title="ProjectName" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.source="https://github.com/st0o0/ProjectName"
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENTRYPOINT ["dotnet", "ProjectName.dll"]
