## Implementation of a sample network in hyperledger fabric


### Folder Structure

```bash
network/
├── config/
│   ├── configtx.yaml         # Network configuration file
│   ├── core.yaml             # File that defines basic configuration 
│   ├── crypto-config-managementOrderer.yaml    # Cryptographic material configuration file for Orderer
│   ├── crypto-config-managementOrg.yaml        # Cryptographic material configuration file for Organization
├── chaincode/
│   ├── mychaincode.go        # Chaincode implementation file
├── scripts/
│   ├── network.sh            # Network setup and management script
│   ├── create-artifacts.sh           # script for creation of certificates
│   ├── create-channel.sh            # Creation of Channel and Joining the peers
├── compose/      
│   ├── docker-compose.yaml            # Docker Compose configuration  file
├── README.md                # Project documentation and instructions
```
