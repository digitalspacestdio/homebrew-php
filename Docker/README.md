create a context
```bash
docker context create arm64-ubuntu --docker "host=tcp://192.168.0.1:2375"
```
or
```bash
docker context create arm64-ubuntu --docker "host=ssh://ubuntu@192.168.0.1:22"
```

append the context
```bash
docker buildx create --name phpbuild --platform linux/amd64
docker buildx create --append --name phpbuild --platform linux/arm64 arm64-ubuntu
docker buildx use phpbuild
docker buildx inspect --bootstrap
```
to remove node
```bash
docker buildx create --leave --name phpbuild --node phpbuild1
docker buildx rm phpbuild
docker context rm arm64-ubuntu
```
