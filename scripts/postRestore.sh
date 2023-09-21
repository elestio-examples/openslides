#Restart the stack after the files are restored
#set env vars
set -o allexport; source .env; set +o allexport;

docker-compose up -d;

#wait until the server is ready
echo "Migration running ..."
sleep 20s;
./openslides migrations finalize
