<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Openslides, verified and packaged by Elestio

[Openslides](https://github.com/Openslides/Openslides) is a free, web based presentation and assembly system for managing and projecting agenda, motions and elections of an assembly.

<img src="https://github.com/elestio-examples/openslides/raw/main/openslides.png" alt="Openslides" width="800">

[![deploy](https://github.com/elestio-examples/openslides/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/openslides)

Deploy a <a target="_blank" href="https://elest.io/open-source/openslides">fully managed Openslides</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want a free and open-source, decentralized, ActivityPub federated video platform powered by WebTorrent, that uses peer-to-peer technology to reduce load on individual servers when viewing videos.

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/openslides.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

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

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:8523`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"

    x-default-environment: &default-environment
      ACTION_HOST: backendAction
      ACTION_PORT: 9002
      AUTH_COOKIE_KEY_FILE: /run/secrets/auth_cookie_key
      AUTH_HOST: auth
      AUTH_PORT: 9004
      AUTH_TOKEN_KEY_FILE: /run/secrets/auth_token_key
      AUTOUPDATE_HOST: autoupdate
      AUTOUPDATE_PORT: 9012
      CACHE_HOST: redis
      CACHE_PORT: 6379
      DATABASE_HOST: postgres
      DATABASE_NAME: openslides
      DATABASE_PASSWORD_FILE: /run/secrets/postgres_password
      DATABASE_PORT: 5432
      DATABASE_USER: postgres
      DATASTORE_DATABASE_HOST: postgres
      DATASTORE_DATABASE_NAME: openslides
      DATASTORE_DATABASE_PASSWORD_FILE: /run/secrets/postgres_password
      DATASTORE_DATABASE_PORT: 5432
      DATASTORE_DATABASE_USER: postgres
      DATASTORE_READER_HOST: datastoreReader
      DATASTORE_READER_PORT: 9010
      DATASTORE_WRITER_HOST: datastoreWriter
      DATASTORE_WRITER_PORT: 9011
      ICC_HOST: icc
      ICC_PORT: 9007
      INTERNAL_AUTH_PASSWORD_FILE: /run/secrets/internal_auth_password
      MANAGE_AUTH_PASSWORD_FILE: /run/secrets/manage_auth_password
      MANAGE_HOST: manage
      MANAGE_PORT: 9008
      MEDIA_DATABASE_HOST: postgres
      AUTOUPDATE_DATABASE_HOST: postgres
      MEDIA_DATABASE_NAME: openslides
      MEDIA_DATABASE_PASSWORD_FILE: /run/secrets/postgres_password
      MEDIA_DATABASE_PORT: 5432
      MEDIA_DATABASE_USER: postgres
      MEDIA_HOST: media
      MEDIA_PORT: 9006
      MESSAGE_BUS_HOST: redis
      MESSAGE_BUS_PORT: 6379
      ICC_REDIS_HOST: redis
      ICC_REDIS_PORT: 6379
      VOTE_REDIS_HOST: redis
      VOTE_REDIS_PORT: 6379
      OPENSLIDES_DEVELOPMENT: "false"
      OPENSLIDES_LOGLEVEL: info
      PRESENTER_HOST: backendPresenter
      PRESENTER_PORT: 9003
      SUPERADMIN_PASSWORD_FILE: /run/secrets/superadmin
      SYSTEM_URL: ${DOMAIN}
      EXTERNAL_ADDRESS: ${DOMAIN}
      VOTE_DATABASE_HOST: postgres
      VOTE_DATABASE_NAME: openslides
      VOTE_DATABASE_PASSWORD_FILE: /run/secrets/postgres_password
      VOTE_DATABASE_PORT: 5432
      VOTE_DATABASE_USER: postgres
      VOTE_HOST: vote
      VOTE_PORT: 9013
      EMAIL_HOST: 172.17.0.1
      EMAIL_PORT: 25
      EMAIL_HOST_USER:
      EMAIL_HOST_PASSWORD:
      EMAIL_CONNECTION_SECURITY: "NONE"
      EMAIL_ACCEPT_SELF_SIGNED_CERTIFICATE: "false"
      DEFAULT_FROM_EMAIL: ${EMAIL_FROM_ADDRESS}

    services:
      proxy:
        image: elestio4test/openslides-proxy:latest
        restart: always
        depends_on:
          - client
          - backendAction
          - backendPresenter
          - autoupdate
          - auth
          - media
          - icc
          - vote
        environment:
          <<: *default-environment
          ENABLE_LOCAL_HTTPS: 1
          HTTPS_CERT_FILE: /run/secrets/cert_crt
          HTTPS_KEY_FILE: /run/secrets/cert_key
        ports:
          - 172.17.0.1:8000:8000
          - 172.17.0.1:8523:8000
        secrets:
          - cert_crt
          - cert_key

      client:
        image: elestio4test/openslides-client:latest
        restart: always
        depends_on:
          - backendAction
          - backendPresenter
          - autoupdate
          - auth
          - media
          - icc
          - vote
        environment:
          <<: *default-environment

      backendAction:
        image: elestio4test/openslides-backend:latest
        restart: always
        depends_on:
          - datastoreWriter
          - auth
          - media
          - vote
          - postgres
        environment:
          <<: *default-environment
          EMAIL_HOST: 172.17.0.1
          EMAIL_PORT: 25
          EMAIL_HOST_USER:
          EMAIL_HOST_PASSWORD:
          EMAIL_CONNECTION_SECURITY: "NONE"
          EMAIL_ACCEPT_SELF_SIGNED_CERTIFICATE: "false"
          DEFAULT_FROM_EMAIL: ${EMAIL_FROM_ADDRESS}
          OPENSLIDES_BACKEND_COMPONENT: action
        secrets:
          - auth_token_key
          - auth_cookie_key
          - internal_auth_password
          - postgres_password

      backendPresenter:
        image: elestio4test/openslides-backend:latest
        restart: always
        depends_on:
          - auth
          - postgres
        environment:
          <<: *default-environment
          OPENSLIDES_BACKEND_COMPONENT: presenter
        secrets:
          - auth_token_key
          - auth_cookie_key
          - postgres_password

      backendManage:
        image: elestio4test/openslides-backend:latest
        restart: always
        depends_on:
          - datastoreWriter
          - postgres
        environment:
          <<: *default-environment
          OPENSLIDES_BACKEND_COMPONENT: action
        secrets:
          - auth_token_key
          - auth_cookie_key
          - internal_auth_password
          - postgres_password

      datastoreReader:
        image: elestio4test/openslides-datastore-reader:latest
        restart: always
        depends_on:
          - postgres
        environment:
          <<: *default-environment
          NUM_WORKERS: "8"
        secrets:
          - postgres_password

      datastoreWriter:
        image: elestio4test/openslides-datastore-writer:latest
        restart: always
        depends_on:
          - postgres
          - redis
        environment:
          <<: *default-environment
        secrets:
          - postgres_password

      postgres:
        image: elestio/postgres:15
        restart: always
        environment:
          <<: *default-environment
          POSTGRES_DB: openslides
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD_FILE: /run/secrets/postgres_password
        ports:
          - 172.17.0.1:5432:5432
        volumes:
          - postgres-data:/var/lib/postgresql/data
        secrets:
          - postgres_password

      autoupdate:
        image: elestio4test/openslides-autoupdate:latest
        restart: always
        depends_on:
          - datastoreReader
          - redis
        environment:
          <<: *default-environment
        secrets:
          - auth_token_key
          - auth_cookie_key
          - postgres_password

      auth:
        image: elestio4test/openslides-auth:latest
        restart: always
        depends_on:
          - datastoreReader
          - redis
        environment:
          <<: *default-environment
        secrets:
          - auth_token_key
          - auth_cookie_key
          - internal_auth_password

      vote:
        image: elestio4test/openslides-vote:latest
        restart: always
        depends_on:
          - datastoreReader
          - auth
          - autoupdate
          - redis
        environment:
          <<: *default-environment
        secrets:
          - auth_token_key
          - auth_cookie_key
          - postgres_password

      redis:
        image: elestio/redis:7.0
        restart: always
        command: redis-server --save ""
        environment:
          <<: *default-environment

      media:
        image: elestio4test/openslides-media:latest
        restart: always
        depends_on:
          - postgres
        environment:
          <<: *default-environment
        secrets:
          - auth_token_key
          - auth_cookie_key
          - postgres_password

      icc:
        image: elestio4test/openslides-icc:latest
        restart: always
        depends_on:
          - datastoreReader
          - postgres
          - redis
        environment:
          <<: *default-environment
        secrets:
          - auth_token_key
          - auth_cookie_key
          - postgres_password

      manage:
        image: elestio4test/openslides-manage:latest
        restart: always
        depends_on:
          - datastoreReader
          - backendManage
        environment:
          <<: *default-environment
          ACTION_HOST: backendManage
        secrets:
          - superadmin
          - manage_auth_password
          - internal_auth_password

      pgadmin4:
        image: dpage/pgadmin4:latest
        restart: always
        environment:
          PGADMIN_DEFAULT_EMAIL: ${ADMIN_EMAIL}
          PGADMIN_DEFAULT_PASSWORD: ${ADMIN_PASSWORD}
          PGADMIN_LISTEN_PORT: 8080
        ports:
          - "172.17.0.1:8080:8080"
        volumes:
          - ./servers.json:/pgadmin4/servers.json

    secrets:
      auth_token_key:
        file: ./secrets/auth_token_key
      auth_cookie_key:
        file: ./secrets/auth_cookie_key
      superadmin:
        file: ./secrets/superadmin
      manage_auth_password:
        file: ./secrets/manage_auth_password
      internal_auth_password:
        file: ./secrets/internal_auth_password
      postgres_password:
        file: ./secrets/postgres_password
      cert_crt:
        file: ./secrets/cert_crt
      cert_key:
        file: ./secrets/cert_key

    volumes:
      postgres-data:
        driver: local
        driver_opts:
          type: none
          device: ${PWD}/postgres-data
          o: bind


### Environment variables

|       Variable       |     Value (example)     |
| :------------------: | :---------------------: |
|   ADMIN_PASSWORD     |  your password          |
|     ADMIN_EMAIL      |  your email             |
|     DOMAIN           |  your domain            |
|  EMAIL_FROM_ADDRESS  |  email                  |
| SOFTWARE_VERSION_TAG |  latest                 |


# Maintenance

## Logging

The Elestio Openslides Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/OpenSlides/openslides-docs">Openslides documentation</a>

- <a target="_blank" href="https://github.com/Openslides/Openslides">Openslides Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/Openslides">Elestio/Openslides Github repository</a>
