docker container stop nzbget
docker container rm nzbget
docker run -itd --restart always --name nzbget --net "Network name" -v b:/Configs/nzbget:c:/ProgramData/nzbget -v b:/Media:c:/usenet -p 6789:6789/tcp -h nzbget nzbget-docker-windows
docker container stop sonarr
docker container rm sonarr
docker run -d --restart always --name sonarr --net "Network name" -v b:/Configs/sonarr:c:/config -v b:/Media:c:/usenet -p 8989:8989/tcp -h sonarr sonarr-docker-windows
docker container stop radarr
docker container rm radarr
docker run -d --restart always --name radarr --net "Network name" -v b:/Configs/radarr:c:/config -v b:/Media:c:/usenet -p 7878:7878/tcp -h radarr radarr-docker-windows
docker container stop lidarr
docker container rm lidarr
docker run -d --restart always --name lidarr --net "Network name" -v b:/Configs/lidarr:c:/config -v b:/Media:c:/usenet -p 8686:8686/tcp -h lidarr lidarr-docker-windows
docker container stop plex
docker container rm plex
docker run -d --restart always --name plex --net "Network name" --isolation process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 -v b:/Configs/plex:"c:/Plex" -v b:/Media:c:/usenet -p 32469:32469/tcp -p 1900:1900/udp -p 32400:32400/tcp -h plex plex-docker-windows
docker container stop navidrome
docker container rm navidrome
docker run -d --restart always --name navidrome --net "Network name" -v b:/Configs/navidrome:c:/config -v b:/Media:c:/usenet -p 4533:4533/tcp -h navidrome navidrome-docker-windows
docker container prune --force