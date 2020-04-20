[![Build Status](https://travis-ci.org/Accenture/adop-docker-compose.svg?branch=master)](https://travis-ci.org/Accenture/adop-docker-compose)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Accenture/ADOP)

# The DevOps Platform: Overview

The DevOps Platform is a tools environment for continuously testing, releasing and maintaining applications. Reference code, delivery pipelines, automated testing and environments can be loaded in via the concept of [Cartridges](https://github.com/Accenture/adop-cartridge-skeleton).

The platform runs on a [docker container cluster](https://docs.docker.com/swarm/) so it can be stood up for evaluation purposes on just one server using local storage, or stood up in a multi-data centre cluster with distributed network storage.  It will also run anywhere that [docker runs](https://docs.docker.com/engine/installation/binaries/).

Here is the front page:

![HomePage](https://raw.githubusercontent.com/jaganthoutam/adop-docker-compose-latest/master/img/projectnew.png)

Once you have a stack up and running, you can log in with the username and password created upon start-up.

If you provisioned your stack using the start-up CLI, an example workspace containing an example project and an example cartridge will all have been pre-loaded in Jenkins:

![HomePage](https://raw.githubusercontent.com/Accenture/adop-docker-compose/master/img/exampleproj.png)

Once you have explored this the next step is to create your own Workspace and Project and then load another cartridge using a 'Load Cartridge' job in the 'Cartridge Management' folder (that automatically gets created in any Project).  The cartridge [development cartridge](https://github.com/accenture/adop-cartridge-cartridge-dev/) also helps create your own cartridges.

# Quickstart Instructions

