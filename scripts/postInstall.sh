#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

# docker-compose exec -T database sh -c "psql -U postgres openslides <<EOF
# \c openslides;
# UPDATE public.models
# SET data = jsonb_set(data, '{url}', '"${DOMAIN}"', false)
# WHERE data ->> 'id' = '1';
# EOF";

# INSERT INTO public.events
# (fqid, type, data, weight) VALUES('organization/1', 'update', '{"url": "${DOMAIN}"}', 1);


./openslides initial-data
./openslides set-password -u 1 -p ${ADMIN_PASSWORD}
./openslides set organization -f - <<< '[{ "id": 1, "url": "https://${DOMAIN}" }]'
./openslides set organization -f - <<< '[{ "id": 1, "name": "Organization" }]'
./openslides set user -f - <<< '[{ "id": 1, "email": "https://${ADMIN_EMAIL}" }]'

# ./openslides set organization.update {url: 'https://yu.com', id: 1}
# ./openslides set organization.update {name: 'Organization', id: 1}
# ./openslides set action -u 1 organization.update {url: "https://yu.com"}
# ./openslides set organization.update {name: 'Organization'}

docker-compose down 

# sed -i "s~127.0.0.1:8000:8000~172.17.0.1:8523:8000~g" ./docker-compose.yml

docker-compose up -d

