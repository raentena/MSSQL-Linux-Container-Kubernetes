# Using Tuned to configure Kernel settings

To enable  Tuned profile, save tuned.conf file under a /usr/lib/tuned/mssql folder, and enable the profile using the following commands:

`chmod +x /usr/lib/tuned/mssql/tuned.conf`
`tuned-adm profile mssql`

Verify it's enabled with the following command:

`tuned-adm active`

# Create and Use SWAP space

```sh 
vgdisplay 


lvcreate -n swaplv -L 8G rootvg


mkswap /dev/rootvg/swaplv


echo '/dev/rootvg/swaplv  swap swap defaults 0 0' >> /etc/fstab

swapon -s

swapon -a

swapon -s

```

