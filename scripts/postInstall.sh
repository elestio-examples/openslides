#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

cat << EOT >> ./secrets/postgres_password


EOT

./openslides initial-data
./openslides set-password -u 1 -p ${ADMIN_PASSWORD}
./openslides set organization -f - <<< '[{ "id": 1, "url": "https://'${DOMAIN}'" }]'
./openslides set organization -f - <<< '[{ "id": 1, "name": "Organization" }]'
./openslides set user -f - <<< '[{ "id": 1, "email": "'${ADMIN_EMAIL}'" }]'

