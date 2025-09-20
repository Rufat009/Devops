
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src


COPY FinanceApp.sln ./
COPY FinanceApp.Core/FinanceApp.Core.csproj FinanceApp.Core/
COPY FinanceApp.Infrastructure/FinanceApp.Infrastructure.csproj FinanceApp.Infrastructure/
COPY FinanceApp.Presentation/FinanceApp.Presentation.csproj FinanceApp.Presentation/
RUN dotnet restore


COPY FinanceApp.Core/ FinanceApp.Core/
COPY FinanceApp.Infrastructure/ FinanceApp.Infrastructure/
COPY FinanceApp.Presentation/ FinanceApp.Presentation/


RUN dotnet publish FinanceApp.Presentation/FinanceApp.Presentation.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "FinanceApp.Presentation.dll"]