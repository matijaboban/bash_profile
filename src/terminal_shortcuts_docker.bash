#!/bin/bash

## docker shortcuts
alias dbea="docker exec -it Beets bash"

## generic docker helpers (if docker is installed)
if command -v docker &>/dev/null; then
    alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
    alias dpsa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
    alias dlogs='docker logs -f'
    alias dstop='docker stop $(docker ps -q) 2>/dev/null'
    alias dprune='docker system prune -f'
    dex() { docker exec -it "$1" "${2:-bash}"; }
fi

## docker-compose shortcuts
if command -v docker-compose &>/dev/null || docker compose version &>/dev/null 2>&1; then
    alias dcu='docker compose up -d'
    alias dcd='docker compose down'
    alias dcl='docker compose logs -f'
    alias dcr='docker compose restart'
    alias dcps='docker compose ps'
fi

## lazydocker (if installed)
command -v lazydocker &>/dev/null && alias lzd='lazydocker'
