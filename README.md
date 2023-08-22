# Openslides CI/CD pipeline

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/openslides"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Deploy Openslides server with CI/CD on Elestio

<img src="openslides.png" style='width: 100%;'/>
<br/>
<br/>

# Once deployed ...

You can open Openslides ADMIN UI here:

    URL: https://[CI_CD_DOMAIN]
    email: superadmin
    password: [ADMIN_PASSWORD]

You can open pgAdmin web UI here:

    URL: https://[CI_CD_DOMAIN]:8443
    email: [ADMIN_EMAIL]
    password: [ADMIN_PASSWORD]

# pgAdmin

To access to the openslides you'll need a password.

To find it open a terminal from your pipeline dashboard and type:

    cat ./secrets/postgres_password
