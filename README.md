# Tailscale Derper Docker Image

This repository contains the Dockerfile and necessary scripts to build a Docker image for Tailscale's Derper. Derper is a standalone DERP server for Tailscale networks. This custom Docker image includes health checks and metadata for easy integration into your infrastructure.

## Features

- **Health Checks**: Included health checks on ports 443 and 3478 ensure the service is running smoothly.
- **OCI Compatible**: The image is tagged with OCI-compatible labels for better integration with container orchestration tools.
- **Custom Startup Script**: Simplifies the process of configuring and starting the Derper server.

## Getting Started

To use this Docker image, you can pull it from the GitHub Container Registry (GHCR) using the following command:

```
docker pull ghcr.io/zfouts/container-tailscale-derp:latest
```


## Usage

After pulling the image, you can run it using Docker with a command like the following:

```
docker run -d --name derper -p 443:443 -p 3478:3478  ghcr.io/zfouts/container-tailscale-derp:latest "-hostname derper.example.com"
```

This will start a Derper server instance running in the background.

### Docker Compose

Alternatively you can use docker compose:

```
services:
  derper:
    image: ghcr.io/zfouts/container-tailscale-derp:latest
    container_name: derper
    ports:
      - "443:443"
      - "3478:3478"
    volumes:
      - /data/tailscale/etc:/opt/tailscale/etc
    restart: unless-stopped
    command: ["-hostname", "derper.example.com"]
```

## Building from Source

If you prefer to build the Docker image from source, clone this repository and run the following command from the root of the project:

```
docker build -t ghcr.io/yourusername/derper:latest .
```

## Contributing

Contributions are welcome! If you have improvements or fixes, please open a pull request or issue in this repository.

## Contact

For questions or feedback regarding this Docker image, please reach out via GitHub issues.

## Legal Disclaimer

WireGuard® is a registered trademark of Jason A. Donenfeld. Usage of the WireGuard trademark is done with acknowledgment to the trademark holder.

Tailscale is subject to its own licensing terms. For details regarding Tailscale's license and usage terms, please refer to their official repository at [Tailscale's GitHub License page](https://github.com/tailscale/tailscale).

This project is not affiliated with, directly endorsed by, or sponsored by WireGuard or Tailscale. All trademarks are the property of their respective owners.


