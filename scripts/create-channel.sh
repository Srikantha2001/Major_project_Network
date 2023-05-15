export PATH=/home/sriki/Documents/Fabric/fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=../config/
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_ORG1_CA=../crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export PEER1_ORG1_CA=../crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
export PEER2_ORG1_CA=../crypto-config/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt
export PEER3_ORG1_CA=../crypto-config/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt
export ORDERER_ADMIN_TLS_SIGN_CERT=../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key   

export CHANNEL_NAME="managementchannel"

setGlobalsForPeer0org1(){
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=../crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8000
}
setGlobalsForPeer1org1(){
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=../crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8001
}
setGlobalsForPeer2org1(){
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER2_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=../crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8002
}
setGlobalsForPeer3org1(){
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER3_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=../crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=localhost:8003
}

createChannel(){
	setGlobalsForPeer0org1
    osnadmin channel join --channelID $CHANNEL_NAME --config-block ../channel-artifacts/${CHANNEL_NAME}.block -o localhost:7100 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY"
    # peer channel create -o localhost:7100 -c $CHANNEL_NAME \
    # --ordererTLSHostnameOverride orderer.example.com \
    # -f ../channel-artifacts/${CHANNEL_NAME}.tx --outputBlock ../channel-artifacts/${CHANNEL_NAME}.block \
    # --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

joinChannel(){
    setGlobalsForPeer0org1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1org1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer2org1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer3org1
    peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block
}

# createChannel
# joinChannel