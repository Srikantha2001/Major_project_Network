export PATH=/home/sriki/Documents/Fabric/fabric-samples/bin:$PATH
export CORE_PEER_TLS_ENABLED=true
export MNG_ORDERER_CA=${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/mngorderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export MNG_PEER0_ORG1_CA=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/peers/peer0.mngorg1.example.com/tls/ca.crt
export MNG_PEER1_ORG1_CA=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/peers/peer1.mngorg1.example.com/tls/ca.crt
export MNG_PEER2_ORG1_CA=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/peers/peer2.mngorg1.example.com/tls/ca.crt
export MNG_PEER3_ORG1_CA=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/peers/peer3.mngorg1.example.com/tls/ca.crt
export MNG_ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/mngorderer.example.com/tls/server.crt
export MNG_ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/mngorderer.example.com/tls/server.key   


export CHANNEL_NAME="managementChannel"
export PATH=/home/sriki/Documents/fabric/fabric-samples/bin:$PATH

setGlobalsForPeer0Mngorg1(){
    export CORE_PEER_LOCALMSPID="MngOrg1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$MNG_PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/users/Admin@mngorg1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8000
}
setGlobalsForPeer1Mngorg1(){
    export CORE_PEER_LOCALMSPID="MngOrg1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$MNG_PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/users/Admin@mngorg1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8001
}
setGlobalsForPeer2Mngorg1(){
    export CORE_PEER_LOCALMSPID="MngOrg1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$MNG_PEER2_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/users/Admin@mngorg1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8002
}
setGlobalsForPeer3Mngorg1(){
    export CORE_PEER_LOCALMSPID="MngOrg1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$MNG_PEER3_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/../crypto-config/peerOrganizations/mngorg1.example.com/users/Admin@mngorg1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8003
}

createChannel(){
	setGlobalsForPeer0Mngorg1
    osnadmin channel join --channelID $CHANNEL_NAME --config-block ../channel-artifacts/${CHANNEL_NAME}.block -o localhost:8000 --ca-file "$MNG_ORDERER_CA" --client-cert "$MNG_ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$MNG_ORDERER_ADMIN_TLS_PRIVATE_KEY"
}

joinChannel(){
    setGlobalsForPeer0Mngorg1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Mngorg1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer2Mngorg1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer3Mngorg1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
}

createChannel
joinChannel