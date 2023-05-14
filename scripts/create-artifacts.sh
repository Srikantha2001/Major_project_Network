
CHANNEL_NAME="mychannel"

# Creation of Peer Organizations certificates using cryptogen tool

cryptogen generate  --config=../config/crypto-config-managementOrg.yaml --output=../crypto-config/
cryptogen generate  --config=../config/crypto-config-doctorOrg.yaml --output=../crypto-config/
cryptogen generate  --config=../config/crypto-config-patientOrg.yaml --output=../crypto-config/


# Creation of Orderer Organizations certificates using cryptogen tool


cryptogen generate --config=../config/crypto-config-managementOrderer.yaml --output=../crypto-config/
cryptogen generate --config=../config/crypto-config-patientDoctorOrderer.yaml --output=../crypto-config/

# Channel Configuration using configtxgen tool

configtxgen -profile OrgsApplicationGenesis -outputBlock ../channel-artifacts/${CHANNEL_NAME}.block -channelID  ${CHANNEL_NAME} -configPath ../config/

# Starting all the docker containers (initial)

docker-compose -f ../compose/docker-compose.yaml up -d