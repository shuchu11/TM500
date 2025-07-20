# Step 1 .Reboot server 
```
sudo reboot
```
# Step 2 . pre-required (In this step ,following commands only need to do once each time reboot the server)
```
cd
sudo su
./ini.sh
```
```
# Create VF and bind VF with DPDK
cd ~/intel_sw/phy
sudo su
./cvl.sh
exit

# set realtime
sudo tuned-adm profile realtime
```
# Step 3 . Run FlexRAN (L1)
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/
source ../../../../../../phy/setupenv.sh 
./l1.sh -xran
```
# Step 4. Run testmac (L2)
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/testmac
source ../../../../../../phy/setupenv.sh 
./l2.sh

// in testmac console:
phystart 4 0 0

runnr 2 1 100 1600
```
