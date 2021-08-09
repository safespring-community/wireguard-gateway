Wireguard connectivity to your project
---------------------------------------

You use this setup to enable a wireguard based VPN-tunnel
from your premises to hosts in your Safespring compute (v2)
project.

The script `setup-wg.sh` will:

- provison a wireguard server in your project with attachment to both public and private network
- setup wireguard interface on the server, routing from that interface to Safespring's `private` network (10.64.0.0/16)
- generate a peer wireguard config, optionally with config for routing traffic from your on-premise networks to 10.64.0.0/16 through your local wireguard peer 

In order to reach instances (with private network only) in your project they must be members of the wireguard-private security group which is created by this setup.
