cp -rf ./openslides-backend/* ./
sed '9c\RUN . requirements/export_service_commits.sh && rm ~/.cache/pip -rf && pip cache purge && pip install --no-cache-dir --requirement requirements/requirements_production.txt' Dockerfile
docker buildx build . --output type=docker,name=elestio4test/openslides-backend:latest | docker load