Wireguard connectivity to your project
---------------------------------------

You use this setup to enable a wireguard based VPN-tunnel
from your premises to hosts in your Safespring compute (v2)
project.

The script `setup-wg.sh` will:

- provison a wireguard server in your projectattached to the ^public` network
- create two security groups that the gateway is member of.
  - One with rules controlling external access. Default is open to the world for wireguard and ssh, but this can be tightened using list variables in terraform variables.
  - One internal that will allow all members full access in between themselves, even if they are on a different network.
- generate a peer wireguard config, optionally with config for routing traffic from your on-premise networks to 10.64.0.0/16 through your local wireguard peer (default on) 

In order to reach instances (with private network only) in your project they must be members of the wireguard-internal security group which is created by this setup.
