## Usage

- Run "build.sh" script. Enter domain name. Enter new CA password when prompted. Then, after initializing PKI, DNS client certificate will be generated. Signing requires unlocking CA with password so it will be asked once again.
- Execute "run.sh" script.
- Generate client config file by running "gen_client.sh" script. Enter new client name, server IP address and port that client should connect to.
- Transfer generated "*.ovpn" config file from "clients/" directory to client machine and use it for connection
