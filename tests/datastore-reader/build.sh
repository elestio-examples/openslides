cp -rf ./openslides-datastore-service/* ./
sed -i 's/ARG PORT/ARG PORT=9010/g' Dockerfile
sed -i 's/ARG MODULE/ARG MODULE=reader/g' Dockerfile
docker buildx build . --output type=docker,name=elestio4test/openslides-datastore-reader:latest | docker load