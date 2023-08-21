#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;


./openslides initial-data
./openslides set-password -u 1 -p ${ADMIN_PASSWORD}

docker-compose down -v --remove-orphans

sed -i "s~127.0.0.1:8000:8000~172.17.0.1:8523:8000~g" ./docker-compose.yml

docker-compose up -d

# salt=$(openssl rand -base64 64)
# hashValue=$(echo -n "$ADMIN_PASSWORD$salt" | openssl dgst -sha512 -binary | base64)


# salt=$(openssl rand -base64 64)
# hashValue=$(echo -n "$ADMIN_PASSWORD$salt" | openssl dgst -sha512 -binary | base64)

# # Encode the hashValue using base64 and escape special characters using jq
# escapedHashValue=$(echo -n "$hashValue" | base64 | jq -sRr @uri)

# echo $escapedHashValue

# docker-compose exec -T postgres sh -c "psql -U openslides openslides <<EOF
# \c openslides
# CREATE EXTENSION IF NOT EXISTS pgcrypto;
# UPDATE public.models
# SET data = jsonb_set(data, '{password}', '\"$escapedHashValue\"'::jsonb, false)
# WHERE data ->> 'id' = '1';
# EOF"


# curl -b cookies.txt 'https://openslidesdsds-u353.vm.elestio.app/system/auth/login/' \
#   -H 'authority: openslidesdsds-u353.vm.elestio.app' \
#   -H 'accept: application/json, text/plain, */*' \
#   -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
#   -H 'cache-control: no-cache' \
#   -H 'content-type: application/json' \
#   -H 'cookie: ph_phc_nSin8j5q2zdhpFDI1ETmFNUIuTG4DwKVyIigrY10XiE_posthog=%7B%22distinct_id%22%3A%22189bb34fe2013f8-0736294de1e37-26031c51-1fa400-189bb34fe211dda%22%2C%22%24device_id%22%3A%22189bb34fe2013f8-0736294de1e37-26031c51-1fa400-189bb34fe211dda%22%2C%22%24user_state%22%3A%22anonymous%22%2C%22%24sesid%22%3A%5B1691071294852%2C%22189bbb42d841749-03fc90d39dbbfe-26031c51-1fa400-189bbb42d8525a7%22%2C1691071294852%5D%2C%22%24session_recording_enabled_server_side%22%3Afalse%2C%22%24autocapture_disabled_server_side%22%3Afalse%2C%22%24active_feature_flags%22%3A%5B%5D%2C%22%24enabled_feature_flags%22%3A%7B%7D%2C%22%24feature_flag_payloads%22%3A%7B%7D%7D' \
#   -H 'ngsw-bypass: true' \
#   -H 'origin: https://openslidesdsds-u353.vm.elestio.app' \
#   -H 'pragma: no-cache' \
#   -H 'referer: https://openslidesdsds-u353.vm.elestio.app/login' \
#   -H 'sec-ch-ua: "Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "Windows"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
#   --data-raw '{"username":"superadmin","password":"superadmin"}' \
#   --compressed

# curl 'https://openslidesdsds-u353.vm.elestio.app/system/auth/login/' \
#   -H 'authority: openslidesdsds-u353.vm.elestio.app' \
#   -H 'accept: application/json, text/plain, */*' \
#   -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
#   -H 'cache-control: no-cache' \
#   -H 'content-type: application/json' \
#   -H 'cookie: ph_phc_nSin8j5q2zdhpFDI1ETmFNUIuTG4DwKVyIigrY10XiE_posthog=%7B%22distinct_id%22%3A%22189bb34fe2013f8-0736294de1e37-26031c51-1fa400-189bb34fe211dda%22%2C%22%24device_id%22%3A%22189bb34fe2013f8-0736294de1e37-26031c51-1fa400-189bb34fe211dda%22%2C%22%24user_state%22%3A%22anonymous%22%2C%22%24sesid%22%3A%5B1691071294852%2C%22189bbb42d841749-03fc90d39dbbfe-26031c51-1fa400-189bbb42d8525a7%22%2C1691071294852%5D%2C%22%24session_recording_enabled_server_side%22%3Afalse%2C%22%24autocapture_disabled_server_side%22%3Afalse%2C%22%24active_feature_flags%22%3A%5B%5D%2C%22%24enabled_feature_flags%22%3A%7B%7D%2C%22%24feature_flag_payloads%22%3A%7B%7D%7D' \
#   -H 'ngsw-bypass: true' \
#   -H 'origin: https://openslidesdsds-u353.vm.elestio.app' \
#   -H 'pragma: no-cache' \
#   -H 'referer: https://openslidesdsds-u353.vm.elestio.app/login' \
#   -H 'sec-ch-ua: "Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "Windows"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
#   --data-raw '{"username":"superadmin","password":"superadmin"}' \
#   --compressed




# curl 'https://openslidessdtury-u353.vm.elestio.app/system/action/handle_request' \
#   -H 'authority: openslidessdtury-u353.vm.elestio.app' \
#   -H 'accept: application/json, text/plain, */*' \
#   -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
#   -H 'authentication: bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uSWQiOiI2YTE0ZDNlYzdiMjc3MDI3NzkzZDNiN2E3OGIyNDU5OSIsInVzZXJJZCI6MSwiaWF0IjoxNjkyNTQwMjgwLCJleHAiOjE2OTI1NDA4ODB9.82lS8Hl1BQFYYMiGhy032yyF_8Jgw11hnuthpM-yGIw' \
#   -H 'cache-control: no-cache' \
#   -H 'content-type: application/json' \
#   -H 'cookie: ph_phc_nSin8j5q2zdhpFDI1ETmFNUIuTG4DwKVyIigrY10XiE_posthog=%7B%22distinct_id%22%3A%22189bb34fe2013f8-0736294de1e37-26031c51-1fa400-189bb34fe211dda%22%2C%22%24device_id%22%3A%22189bb34fe2013f8-0736294de1e37-26031c51-1fa400-189bb34fe211dda%22%2C%22%24user_state%22%3A%22anonymous%22%2C%22%24sesid%22%3A%5B1691071294852%2C%22189bbb42d841749-03fc90d39dbbfe-26031c51-1fa400-189bbb42d8525a7%22%2C1691071294852%5D%2C%22%24session_recording_enabled_server_side%22%3Afalse%2C%22%24autocapture_disabled_server_side%22%3Afalse%2C%22%24active_feature_flags%22%3A%5B%5D%2C%22%24enabled_feature_flags%22%3A%7B%7D%2C%22%24feature_flag_payloads%22%3A%7B%7D%7D; refreshId=bearer%20eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uSWQiOiI2YTE0ZDNlYzdiMjc3MDI3NzkzZDNiN2E3OGIyNDU5OSIsInVzZXJJZCI6MSwiaWF0IjoxNjkyNTQwMjgwLCJleHAiOjE2OTUxMzIyODB9.dJ2feI8fehJWAgFg428DCLDbWJDxoExv6W8k7QTU4Ns' \
#   -H 'ngsw-bypass: true' \
#   -H 'origin: https://openslidessdtury-u353.vm.elestio.app' \
#   -H 'pragma: no-cache' \
#   -H 'referer: https://openslidessdtury-u353.vm.elestio.app/settings' \
#   -H 'sec-ch-ua: "Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "Windows"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
#   --data-raw '[{"action":"user.set_password_self","data":[{"old_password":"superadmin","new_password":"Test1234#"}]}]' \
#   --compressed