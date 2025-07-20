#!/bin/sh

# execute it once after reboot

# bind VRB1 HW accelerator to DPDK driver vfio-pci
cd /home/ubuntu/dpdk-stable-22.11.1/usertools/
./dpdk-devbind.py -b vfio-pci f7:00.0
# check bind status
./dpdk-devbind.py -s

# enable SRIOV for VRB1 VF feature
echo 1 | tee /sys/module/vfio_pci/parameters/enable_sriov
echo 1 | tee /sys/module/vfio_pci/parameters/disable_idle_d3

# configure VRB1 to VF (16VF for both LTE & NR usage)
cd /home/ubuntu/pf-bb-config 
./pf_bb_config VRB1 -v 00112233-4455-6677-8899-aabbccddeeff -c ./vrb1/vrb1_config_16vf.cfg

# generate 1 VF of this VRB1(its PCIe add may be f7:00.1 )
echo 1 > /sys/bus/pci/devices/0000:f7:00.0/sriov_numvfs
