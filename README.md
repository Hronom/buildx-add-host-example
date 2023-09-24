# buildx-add-host-example
`buildx` - Accessing a container on a named network with `--add-host`

**BIG RESPECT** to author `poconnor-lab49` of this post: [Options for connecting to a running docker container during a build using buildx](https://twl.lab49.com/author/poconnor-lab49/afaa80643a69ababdb1308fdb7b7ee9c) for solution inspiration.

This repo implements approach `(Better) buildx - Accessing a container on a named network with --add-host`

It's a workaround to https://github.com/docker/buildx/issues/175

## Local usage
Start dependencies by using docker compose:
```shell
docker compose up -d
```

Check running container:
```shell
docker ps
```

List networks:
```shell
docker network ls
```

Remove current builder (Optional):
```shell
docker buildx rm
```

Create builder:
```shell
docker buildx create --driver-opt network=buildx-add-host-example_default --name mybuilder --use
```

Check used network
```shell
docker buildx inspect --bootstrap
```

```shell
docker buildx build -f Dockerfile \
            --add-host echo-server-1:$(docker inspect echo-server-1 | jq '.[0].NetworkSettings.Networks["buildx-add-host-example_default"].IPAddress' | tr -d '"\n') \
            --add-host echo-server-2:$(docker inspect echo-server-2 | jq '.[0].NetworkSettings.Networks["buildx-add-host-example_default"].IPAddress' | tr -d '"\n') \
            --add-host echo-server-3:$(docker inspect echo-server-3 | jq '.[0].NetworkSettings.Networks["buildx-add-host-example_default"].IPAddress' | tr -d '"\n') \
            .
```

Cleanup:
```shell
docker buildx rm
```

```shell
docker compose down -v
```

## GitHub Actions
Check `Build` workflow.
