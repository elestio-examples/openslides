cp -rf ./openslides-vote-service/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-vote:latest | docker load