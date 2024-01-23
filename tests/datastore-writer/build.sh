cp -rf ./openslides-datastore-service/* ./
sed -i 's/ARG PORT/ARG PORT=9011/g' Dockerfile
sed -i 's/ARG MODULE/ARG MODULE=writer/g' Dockerfile
docker buildx build . --output type=docker,name=elestio4test/openslides-datastore-writer:latest | docker load