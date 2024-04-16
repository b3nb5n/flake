# Dev Container Setup

1. build flake output or download artifact from [github actions](https://github.com/b3nb5n/nix-flake/actions)
2. unzip artifact `unzip dev-container.zip`
3. load image into docker `docker load < result`
4. start container `docker run -itd --name dev-container --mount type=bind,source=$HOME/Desktop,destination=/build REPLACE_WITH_IMAGE_HASH`
5. attach to container `docker attach dev-container`

## Auto attaching stript
```bash
export DEV_CONTAINER_NAME="dev-container"
if [ ! $(docker ps -q -f name=$DEV_CONTAINER_NAME) ]; then
    echo "Docker container '$DEV_CONTAINER_NAME' is not running, starting it now..."
    docker start $DEV_CONTAINER_NAME || echo "Error starting container '$DEV_CONTAINER_NAME'"
else
    echo "Docker container '$DEV_CONTAINER_NAME' is already running"
fi

echo "Attaching shell to container '$DEV_CONTAINER_NAME'"
docker attach $DEV_CONTAINER_NAME || echo "Error attaching to container '$DEV_CONTAINER_NAME'"
```

