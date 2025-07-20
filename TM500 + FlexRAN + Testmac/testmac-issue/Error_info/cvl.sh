
echo "0" > /sys/class/net/ens1f1/device/sriov_numvfs

echo "1" > /sys/class/net/ens1f1/device/sriov_numvfs

sleep 5

sudo ip link set ens1f1 vf 0 mac 00:11:22:33:44:66 vlan 5 qos 1 spoofchk on trust off
#sudo ip link set ens1f1 vf 1 mac 00:11:22:33:44:89 vlan 5 qos 1 spoofchk on trust off

modprobe vfio_pci

sudo /usr/local/bin/dpdk-devbind.py --bind vfio-pci 0000:70:11.0

sudo ifconfig ens1f1 mtu 9000 
sudo ethtool -G ens1f1 rx 4096 tx 4096


