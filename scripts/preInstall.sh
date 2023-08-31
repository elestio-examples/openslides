#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./postgres-data
chown -R 1000:1000 ./postgres-data

wget https://github.com/OpenSlides/openslides-manage-service/releases/download/latest/openslides
chmod +x openslides
./openslides setup .


cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 5432,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT