# media-docker-windows
The media-docker-windows project is a collection of Docker scripts that can be used to set up a self-hosted media stack running natively on Windows. As there are multiple Docker scripts for the same services on Linux, this is a method to have a similar set up 
without having to rely on Virtual Machines or any additional virtualization solution.

## Services available
The following services are part of this repository
 * [NZBGet](https://nzbget.net/)
 * [Sonarr](https://sonarr.tv/)
 * [Radarr](https://radarr.video/)
 * [Lidarr](https://lidarr.audio/)
 * [Plex](https://www.plex.tv/)
 * [Navidrome](https://www.navidrome.org/)

## Assumptions, pre-conditions and additional considerations
 * The use of these scripts assume that you're familiar with the use of Docker and the Windows command line.
 * Furthermore, this assumes that you're using the [native version of docker for Windows](https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce).
 * The following servers can be configured once they are running:
   * [nzbget-docker-windows](./nzbget-docker-windows/)
   * [sonarr-docker-windows](./sonarr-docker-windows/)
   * [radarr-docker-windows](./radarr-docker-windows/)
   * [lidarr-docker-windows](./lidarr-docker-windows/)
   * [plex-docker-windows](./plex-docker-windows/)
 * [navidrome-docker-windows](./navidrome-docker-windows) requires a configuration file to be set-up before initial deployment
 * The [plex-docker-windows](./plex-docker-windows/) script users a binary to synchronize its registry between restarts. Code can be found at [@dr1rrb's repository](https://github.com/dr1rrb/docker-registry-sync).

## Goals / To Dos
 - [x] Initial write-up
 - [ ] Docker Compose script for the entire image catalog
 - [ ] Add Calibre / alternative solution for book reading
 - [ ] Add uptime / monitoring services (such as Homer.io)
 - [ ] Pass configuration file as parameters (optional) when possible
 - [ ] Migrate from NZBGet to a different service as it has been archived since Nov 18, 2022 (https://github.com/nzbget/nzbget)
 - [ ] Remove dependencies on Chocolatey and directly obtain installers directly
 - [ ] Build log history and reporting on build issues
 - [ ] Complete / Enable use Nvidia GPUs on Plex container
 - [ ] Complete / Enable use AMD GPUs on Plex container

## Configure containers manually
The following commands are used to build the Docker container with the latest versions available, and to deploy them manually.

 ### NZBGet
 ```powershell
 # To build a NZBGet container
 docker build .\nzbget-docker-windows\ --tag nzbget-docker-windows
 
 # To run an instance of the NZBGet container
 docker run -itd --restart always --name nzbget --net "Network name" -v b:/Configs/nzbget:c:/ProgramData/nzbget -v b:/Media:c:/usenet -p 6789:6789/tcp -h nzbget nzbget-docker-windows
 ```

 ### Sonarr
 ```powershell
 # To build a Sonarr container
 docker build .\sonarr-docker-windows\ --tag sonarr-docker-windows

 # To run an instance of the Sonarr container
 docker run -d --restart always --name sonarr --net "Network name" -v b:/Configs/sonarr:c:/config -v b:/Media:c:/usenet -p 8989:8989/tcp -h sonarr sonarr-docker-windows
 ```
 ### Radarr
 ```powershell
 # To build a Radarr container
 docker build .\radarr-docker-windows\ --tag radarr-docker-windows

 # To run an instance of the Radarr container
 docker run -d --restart always --name radarr --net "Network name" -v b:/Configs/radarr:c:/config -v b:/Media:c:/usenet -p 7878:7878/tcp -h radarr radarr-docker-windows
 ```
 
 ### Lidarr
 ```powershell
 # To build a Lidarr container
 docker build .\lidarr-docker-windows\ --tag lidarr-docker-windows

# To run an instance of the Lidarr container
 docker run -d --restart always --name lidarr --net "Network name" -v b:/Configs/lidarr:c:/config -v b:/Media:c:/usenet -p 8686:8686/tcp -h lidarr lidarr-docker-windows
 ```
 ### Plex
 *Note:* The current "docker run" commands for Plex have flags to allow the container to use GPU acceleration (including the level of isolation, and the device class assigned to the container), however the actual container image does not use the GPU drivers as of now.
 ```powershell
 # To build a Plex container
 docker build .\plex-docker-windows\ --tag plex-docker-windows

# To run an instance of the Plex container
 docker run -d --restart always --name plex --net "Network name" --isolation process --device class/5B45201D-F2F2-4F3B-85BB-30FF1F953599 -v b:/Configs/plex:"c:/Plex" -v b:/Media:c:/usenet -p 32469:32469/tcp -p 1900:1900/udp -p 32400:32400/tcp -h plex plex-docker-windows
 ```
 ### Navidrome
 ```powershell
 # To build a Navidrome container
 docker build .\navidrome-docker-windows\ --tag navidrome-docker-windows

 # To run an instance of the Navidrome container
 docker run -d --restart always --name navidrome --net "Network name" -v b:/Configs/navidrome:c:/config -v b:/Media:c:/usenet -p 4533:4533/tcp -h navidrome navidrome-docker-windows
 ```


## Automate deployment and build of servers
There are two scripts in this container that allow for rebuilding the containers in a periodic basis, and to relaunch the servers as needed. These are:
* docker-build.ps1 - Rebuilds the docker containers and purges the previous images used
* docker-restart.ps1 - Stops the containers, removes the old versions (which should be untagged) and starts new containers with the latest images rebuilt

## References
 * This repository uses code from [@BootyBerry](https://github.com/bootyberry/win-containers/) and [@dr1rrb](https://github.com/dr1rrb/docker-plex-win)

