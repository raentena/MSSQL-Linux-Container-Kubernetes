# Using Tuned to configure Kernel settings
Examine the content of tuned.conf 

` cat tuned.conf ` 

You will notice all the kernel parameters that needed to optimize Linux is set on the tuned.conf 

To enable  Tuned profile, save tuned.conf file under a /usr/lib/tuned/mssql folder, and enable the profile using the following commands:

`chmod +x /usr/lib/tuned/mssql/tuned.conf`

`tuned-adm profile mssql`

Verify it's enabled with the following command:

`tuned-adm active`

# blockdev command
Use blockdev to set the Block access Size

` blockdev --report`

` blockdev --getra /dev/sda2 ` 

` blockdev --setra 4096 /dev/sda2 `

` blockdev --report`

# Create and Use SWAP space
Verify the remaining size of VolumeGroup before creating a SWAP device

```sh 
vgdisplay 
```

Create new Logical Volume for SWAP and enable it as SWAP Drive

```sh 

lvcreate -n swaplv -L 8G rootvg

mkswap /dev/rootvg/swaplv

echo '/dev/rootvg/swaplv  swap swap defaults 0 0' >> /etc/fstab

swapon -s

swapon -a

swapon -s

```

# Enable noatime for root device 
Check for current settings

```sh 
grep  rootvg-rootlv /etc/fstab 

vim  /etc/fstab 

```

In the vim session add, 'noatime' options beside defaults under  rootvg-rootlv device 

Save and Exit vim session 

Remount to enable noatime 

```sh 
systemctl restart systemd-remount-fs.service 
```

Verify noatime been applied

```sh 
 mount | grep  noatime
 ```

 END