#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

# docker-compose exec -T database sh -c "psql -U openslides openslides <<EOF
# \c openslides
# UPDATE public.models
# SET data = jsonb_set(data, '{url}', '"${DOMAIN}"', false)
# WHERE data ->> 'id' = '1';
# EOF";


./openslides initial-data
./openslides set-password -u 1 -p ${ADMIN_PASSWORD}

# ./openslides set organization.update {url: 'https://yu.com', id: 1}
# ./openslides set organization.update {name: 'Organization', id: 1}
# openslides set meeting -f - <<< '[{ "id": 12, "name": "cool meeting" }]'
# ./openslides set action -u 1 organization.update {url: "https://yu.com"}
# ./openslides set organization.update {name: 'Organization'}

docker-compose down -v --remove-orphans

sed -i "s~127.0.0.1:8000:8000~172.17.0.1:8523:8000~g" ./docker-compose.yml

docker-compose up -d

