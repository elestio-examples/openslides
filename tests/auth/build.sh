cp -rf ./openslides-auth-service/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-auth:latest | docker load