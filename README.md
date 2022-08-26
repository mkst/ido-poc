# ido5.3 i386 alpine poc

Minimal Docker image containing a i386 version of [ido5.3 recomp](https://github.com/Emill/ido-static-recomp).

```
/compiler/ido5.3/cc: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-musl-i386.so.1, with debug_info, not stripped
```

**Build image:**
```sh
docker build . \
    -t ido:5.3-alpine
```

**Check image size:**
```sh
$ docker image ls | head -2
# REPOSITORY    TAG          IMAGE ID       CREATED         SIZE
# ido           5.3-alpine   fe84a049cab5   2 seconds ago   18.9MB
```

**Run the example:**
```sh
docker run \
    --platform linux/386 \
    --rm \
    ido:5.3-alpine
```

**Run an interactive shell:**
```sh
docker run \
    --platform linux/386 \
    -ti \
    --rm \
    ido:5.3-alpine sh
```
