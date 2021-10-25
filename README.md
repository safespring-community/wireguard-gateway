Wireguard connectivity to your project
---------------------------------------

You use this setup to enable a wireguard based VPN-tunnel
from your premises to hosts in your Safespring compute (v2)
project.

**NB:** This setup will only take care of traffic initiated from the "on premise" side of the tunnel.
If you need to go the other direction, the traffic **must** be encapsulated in a tunnel all the way from
the instance in safespring's new platfrom (with calico L3 networking only). Otherwise packets destined
towards any rfc1918 (private subnets) will be ignored on the way out because the calico router won't have
a valid next hop.

The script `setup-wg.sh` will:

- provison a wireguard server in your projectattached to the ^public` network
- create two security groups that the gateway is member of.
  - One with rules controlling external access. Default is open to the world for wireguard and ssh, but this can be tightened using list variables in terraform.
  - One internal that will allow all members full access in between themselves, even if they are on a different network.
- generate a peer wireguard config, optionally with config for routing traffic from your on-premise networks to 10.64.0.0/16 through your local wireguard peer (default on) 

In order to reach instances (with private network only) in your project they must be members of the wireguard-internal security group which is created by this setup.

Please override the variable `wg_allowed_ips:` in
`roles/wireguard/vars/main.yml` in order to deploy the setup to another site
with another private ip range. `192.168.66.0/24` always needs to be in the
list. `10.64.0.0/16` is the subnet range of the private network in sto1v2 and
need to be changed according to the correct range if deploying in other sites.

