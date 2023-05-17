FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

COPY SampleWebApplication .
RUN powershell nuget restore
# RUN msbuild /p:Configuration=Release /p:publishUrl=/out /p:DeployDefaultTarget=WebPublish /p:DeployOnBuild=True /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True
RUN msbuild /p:Configuration=Release 

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
WORKDIR /app
COPY --from=build /out /inetpub/wwwroot
