# NAT Instance vs NAT Gatewaty

In both cases, the main reason is to let an instance in private subnet to coonnect to internet.

Why instance in private subnet wants to connect to internet? This is usefull for package download (yum, apt, dnf ..), applying security patches, etc.

In order to use NAT instance instead of NAT Gateway :

- Create EC2 instance, disable source/destination check for it.
  
- EC2 must be in public subnet
  
- Allow all outbound traffic from NAT instance to private one, using public subnet security group. Of course, we can narrow to specific security group that only applies to NAT instance instead of its whole public subnet.
- Allow all inbound traffic to private instance from NAT one. This also can be done on security group that applies to whole private subnet or be specific to a private instance.

In both cases, we can allow specific range of ports/protocols instead of allowing all traffic.
