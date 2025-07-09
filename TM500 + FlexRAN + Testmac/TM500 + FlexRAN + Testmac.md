
# Run Application
## 1. TM500 Status
### Step1.1 Configure TM500
For this integration, we're using a [CSV file](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/7e9067064f0b8ad226df4e8fe7e09c8172f84c5f/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Intel%20TM500%20RU%20and%20UE%20configs/TM500%20RU%20and%20UE%20configs/oran_2_0_defaults.csv) provided by Intel. To better identify it, we've changed the filename to [4x4_9000_testmac.csv](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20TM500%20RU%20and%20UE%20configs/4x4_9000_testmac.csv).

### Step1.2 Bring up TM500(cloudUE)
* In Control PC , open [MobaXterm](https://mobaxterm.mobatek.net/download-home-edition.html)  and use SSH to access TM500 server ( 192.168.8.67 ) .