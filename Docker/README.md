
to append node
```bash
docker context create arm64-ubuntu --docker "host=ssh://ubuntu@192.168.0.1:22"
docker buildx create --name phpbuild --platform linux/amd64
docker buildx create --append --name phpbuild --platform linux/arm64 arm64-ubuntu
docker buildx use phpbuild
docker buildx inspect --bootstrap
```
to remove node
```bash
docker buildx create --leave --name phpbuild --node phpbuild1
docker buildx rm phpbuild
```
