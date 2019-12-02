FROM mcr.microsoft.com/windows:1809

RUN dism.exe /online /enable-feature /all /featurename:iis-webserver /NoRestart
RUN dism.exe /online /enable-feature /all /featurename:IIS-ASPNET45
RUN %windir%\system32\inetsrv\appcmd.exe set AppPool "DefaultAppPool" -processModel.identityType:LocalSystem

RUN powershell -Command \
  $ErrorActionPreference = 'Stop'; \
  Set-ExecutionPolicy Unrestricted -Force; \
  Invoke-WebRequest -UseBasicParsing \
        -Uri "https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.6/ServiceMonitor.exe" \
        -OutFile "C:\\ServiceMonitor.exe"; 
  
COPY app/. c:/inetpub/wwwroot/.

EXPOSE 80

CMD ["C:\\ServiceMonitor.exe", "w3svc"]