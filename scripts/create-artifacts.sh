
# imports
. create-channel.sh

CHANNEL_NAME="managementChannel"

# Creation of Peer Organizations certificates using cryptogen tool

# Exporting path to fabric-tools 

export PATH=/home/sriki/Documents/Fabric/fabric-samples/bin:$PATH

if [ ! -d "../channel-artifacts" ]; then
    mkdir ../channel-artifacts
fi

cryptogen generate  --config=../config/crypto-config-managementOrg.yaml --output=../crypto-config/

# Creation of Orderer Organizations certificates using cryptogen tool

cryptogen generate --config=../config/crypto-config-managementOrderer.yaml --output=../crypto-config/

# Channel Configuration using configtxgen tool

configtxgen -profile ManagementArtifactsGenesis -outputBlock ../channel-artifacts/${CHANNEL_NAME}.block -channelID  ${CHANNEL_NAME} -configPath ../config/

# Starting all the docker containers (initial)

docker-compose -f ../compose/docker-compose.yaml up -d

# createChannel
# joinChannel