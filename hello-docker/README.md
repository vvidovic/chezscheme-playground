# Hello World project running chez scheme in docker

Example Hello World project running in Docker using chez scheme.

## Run locally

```
scheme -q hello.ss
```

## Compile for faster startup

```
echo '(compile-file "hello.cs")' | scheme
scheme -q hello.so
```

## Build & run docker

```
docker build . -t scheme_hello
docker run --rm scheme_hello
```
