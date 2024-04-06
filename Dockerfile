# Stage 1: Build
FROM golang:1.22.2-alpine3.19 as builder

# Set the working directory
WORKDIR /build

# Install dependencies
RUN apk add --no-cache git

# Build derper from the source
RUN go install tailscale.com/cmd/derper@main

# Stage 2: Final Image
FROM alpine:3.19

# Metadata Labels
LABEL org.opencontainers.image.title="Tailscale Derper Image" \
      org.opencontainers.image.description="Custom image for Tailscale's Derper with health checks." \
      org.opencontainers.image.source="https://github.com/zfouts/container-tailscale-derp" \
      org.opencontainers.image.vendor="Zachary Fouts" \
      org.opencontainers.image.authors="Zachary Fouts <hello@fouts.dev>" \
      org.opencontainers.image.licenses="BSD-3-Clause" 
# Copy the derper binary from the builder stage
COPY --from=builder /go/bin/derper /opt/tailscale/bin/derper

# Create necessary directories
RUN mkdir -p /opt/tailscale/etc /opt/tailscale/etc/certs && \
    apk add --no-cache netcat-openbsd 

# Health checks for ports 443 and 3478
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD nc -z localhost 443 || nc -z localhost 3478

# Set the startup command
ENTRYPOINT ["/opt/tailscale/bin/derper", "-c", "/opt/tailscale/etc/derp.conf", "-certdir", "/opt/tailscale/etc/certs"]
