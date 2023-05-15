
# imports
. create-channel.sh
###################################################################
#                   SCRIPT FILE FOR INITIAL CONFIGURATION
###################################################################


# VARIABLES

CHANNEL_NAME="managementchannel"


# EXPORTS
export FABRIC_CFG_PATH=../config/
export PATH=/home/sriki/Documents/Fabric/fabric-samples/bin:$PATH


# CREATION OF DIRECTORIES

if [ ! -d "../crypto-config" ]; then
    mkdir ../crypto-config
fi


if [ ! -d "../channel-artifacts" ]; then
    mkdir ../channel-artifacts
fi

# Creation of Peer Organizations certificates using cryptogen tool

cryptogen generate  --config=../config/crypto-config-managementOrg.yaml --output=../crypto-config/

# Creation of Orderer Organizations certificates using cryptogen tool

cryptogen generate --config=../config/crypto-config-managementOrderer.yaml --output=../crypto-config/

# Channel Configuration using configtxgen tool

configtxgen -profile ManagementArtifactsGenesis -outputBlock ../channel-artifacts/${CHANNEL_NAME}.block -channelID  ${CHANNEL_NAME} -configPath ../config/

configtxgen -profile BasicChannel -outputCreateChannelTx ../channel-artifacts/${CHANNEL_NAME}.tx  -channelID  ${CHANNEL_NAME} -configPath ../config/

# Starting all the docker containers (initial)

docker-compose -f ../compose/docker-compose.yaml up -d

# Creating and starting the containers

# createChannel
# joinChannel

