docker build .\nzbget-docker-windows\ --no-cache --tag nzbget-docker-windows
docker build .\sonarr-docker-windows\ --no-cache --tag sonarr-docker-windows
docker build .\radarr-docker-windows\ --no-cache --tag radarr-docker-windows
docker build .\lidarr-docker-windows\ --no-cache --tag lidarr-docker-windows
docker build .\plex-docker-windows\ --no-cache --tag plex-docker-windows
docker build .\navidrome-docker-windows\ --no-cache --tag navidrome-docker-windows
docker image prune -f