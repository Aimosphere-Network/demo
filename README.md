# demo

The demo project runs the aimosphere network in the following configuration:

- alice: validator
- bob: validator, provider
- charlie: validator, provider

```mermaid
flowchart TD
    CP[cockpit] --- A{node-alice}
    A ---|chain| B{node-bob} & C{node-charlie}
    subgraph charlie
    C --- WC[wingman-charlie]
    end
    subgraph bob
    B --- WB[wingman-bob]
    end
    subgraph cog
    CHW(cog-hello-world)
    end   
    charlie & bob --- cog 
    A & B & C -.- HC((chain-health))
```

## build docker images

To run the demo the following images should be built.

1. aimosphere/airo

cd into the `airo-node` directory and run
```sh
docker build -t aimosphere/airo .
```

2. aimosphere/wingman and cog-hello-world model

cd into the `airo-wingman` directory and run
```sh
docker build -t aimosphere/wingman .
```

then cd into the `airo-wingman/.maintain/cog/hello-world` directory and run
```sh
cog build -t cog-hello-world
```

Please, follow [this guide](https://github.com/replicate/cog?tab=readme-ov-file#install) to install cog

3. aimosphere/cockpit

cd into the `cockpit` directory and run
```sh
docker build -t aimosphere/cockpit .
```

4. aimosphere/chain-health

cd into the `chain-health` directory of the current project and run 
```sh
docker build -t aimosphere/chain-health .
```

## run demo

To run the demo, execute the following command in the root directory of the project
```sh
docker-compose up
```

It will start all the required containers.

To access the cockpit, go to [http://localhost:8080](http://localhost:8080). By default, it is attached to `node-alice`.

Bob's wingman UI (swagger) is available at [http://localhost:8000/swagger-ui/](http://localhost:8000/swagger-ui/) and Charlie's at [http://localhost:8001/swagger-ui/](http://localhost:8001/swagger-ui/)