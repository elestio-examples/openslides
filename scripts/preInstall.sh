#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./postgres-data
chown -R 1000:1000 ./postgres-data

wget https://github.com/OpenSlides/openslides-manage-service/releases/download/latest/openslides
chmod +x openslides
./openslides setup .