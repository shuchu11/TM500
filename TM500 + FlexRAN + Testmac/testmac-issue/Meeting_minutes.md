# Information
Date :2025.07.20 \
Time : 14:00 - 15.40\
member : Kyle , Leo
# Issue
problem : testmac issue（ At first ,we found Layer 1 automatically crash within 5 mins）and we rebooted our server three times, the issue remains unresolved.\
These are the steps I followed to operate the server. : [Step.md](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/c4a5675c8da8fa920b7cd0ccf09b2e20e15f219d/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/Error_info%20/Step.md)

[Layer1 log](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/c4a5675c8da8fa920b7cd0ccf09b2e20e15f219d/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/Error_info%20/L1_log)

[Layer2 log](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/c4a5675c8da8fa920b7cd0ccf09b2e20e15f219d/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/Error_info%20/L2_log)

[cvl.sh](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/c4a5675c8da8fa920b7cd0ccf09b2e20e15f219d/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/Error_info%20/cvl.sh)

[ini.sh](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/c4a5675c8da8fa920b7cd0ccf09b2e20e15f219d/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/Error_info%20/ini.sh)


# Result 
Now, testmac can run for over 90 mins without crashing.

<img width="1583" height="174" alt="螢幕擷取畫面 2025-07-18 165011" src="https://github.com/user-attachments/assets/0689f5c2-7b4a-4327-bb92-9ffbf1279643" />

# method
We use the another method(this was got from Intel before) to bring up testmac.\

* **Original method** 
In this integration, we use [testcase 600](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/tree/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20FlexRAN%20and%20Testmac%20configs/600)
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/testmac
source ../../../../../../phy/setupenv.sh 
./l2.sh

// in testmac console:
phystart 4 0 0

runnr 2 1 100 1600
```

* **New method**
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/testmac
source ../../../../../../phy/setupenv.sh 
./l2.sh --testfile=sprsp_mcc_mu1_100mhz_4x4_hton.cfg
```
[sprsp_mcc_mu1_100mhz_4x4_hton.cfg](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/14f3f835091579b8094aa6c38e2857ce19e19ee3/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/cfg_FILE/V2.0_sprsp_mcc_mu1_100mhz_4x4_hton.cfg)

Although Sheryl's notes (see image below) show that we had known about this method for quite some time, we only made slight modifications to the `sprsp_mcc_mu1_100mhz_4x4_hton.cfg` file. Now, testmac has been running for over 90 mins without crashing.
<img width="1074" height="252" alt="image" src="https://github.com/user-attachments/assets/b10d29ed-1688-46bd-8d1d-7e144676b49d" />

Changes made to the `sprsp_mcc_mu1_100mhz_4x4_hton.cfg` file [ori_sprsp_mcc_mu1_100mhz_4x4_hton.cfg](https://github.com/shuchu11/TM500-FlexRAN-Testmac-NOTE/blob/14f3f835091579b8094aa6c38e2857ce19e19ee3/TM500%20%2B%20FlexRAN%20%2B%20Testmac/testmac-issiue/cfg_FILE/sprsp_mcc_mu1_100mhz_4x4_hton.cfg):

```
# setoption spr_pipeline 1     # We commented out this line

setcore 0x3000000030  # This line was originally setcore 0x1000000010
```
