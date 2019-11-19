FROM mcr.microsoft.com/windows:2019
#FROM mcr.microsoft.com/windows/servercore:ltsc2019 working
RUN dism.exe /online /enable-feature /all /featurename:iis-webserver /NoRestart
RUN echo "Hello World - Dockerfile" > c:\inetpub\wwwroot\index.html
CMD [ "cmd" ]