# <center>Integration Guide of TM500 + FlexRAN + testmac</center>
**🎯 Readme:** 
1. If you encounter an error you can refer to the [Trouble Shoot](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Troubleshoot%20of%20TM500%2BFlexRAN%2Btestmac.md).

**:mahjong:Contributer:** 
- `Sheryl`
---
## Topology
![image](https://github.com/user-attachments/assets/9131b52a-9c66-4885-bf64-ca4b22086217)
## [MSC](https://sequencediagram.org/index.html#initialData=A4QwTgLglgxloDsIAIBEAxANgUwB4CUBBAOVWRAGdkAZARgChRJZ4Qk0JsKIBbEGMpRoAmenQA8AWhEAuZAFkAygHEA+gBUAmgAUAoqu0AJTRt2L1qgMIB5YugCSa+3etjakgHzVhcpWq16BsZWtg5q+Gba9NESkt4yfho6+kYm5oT4FhEAim6e8YkBKcHpmaoRilF5Xj6KmAD2KFAIACawIND1CEA)
![image](https://github.com/user-attachments/assets/8b5216c3-9c83-4760-9f11-37a1ca9ad0f7)


## Access Method
**TM500 Server (Supermicro) :**
- IP Address : 192.168.8.67
- Username : viavi
- Password : viavi

**TM500 Control PC :**
- IP Address : 192.168.8.68
	- User Password : bmwee809
- Anydesk ID : 1549083559
	- Anydesk Password : bmwbmwbmwee809

**FlexRAN+xFAPI+OSC O-DU HIGH+OAI CU(Supermicro) :**
- IP Address : 192.168.8.76
	- Username : ubuntu
	- Password : bmwlab
	- Root Password : bmwlab
- IDRAC IP : 192.168.10.87
	- IDRAC user name : ADMIN
	- IDRAC Password : WDLZISCGYS

## Environment
### FlexRAN 
**Hardware:**
|     Item     | Info                                             |
|:------------:| ------------------------------------------------ |
|     CPU      | Intel® Xeon® Gold 6433N CPU @ 3.60GHz (64 cores) |
|    Memory    | 251 GB                                           |
|     Disk     | 879 GB                                           |
|     NIC      | Intel Ethernet Controller E810-XXV for SFP (x2)  |
| Server Model | Supermicro SYS-111E-WR                           | 

**Software:**
|   **Item**    | **Info**                           |
|:-------------:|:---------------------------------- |
|      OS       | Ubuntu 22.04.4 LTS                 |
|    Kernel     | Linux maxwell 5.15.0-1069-realtime |
|     DPDK      | 22.11.1                            |
|   LinuxPTP    | 3.1.1                              |
| l1app Branch  | FlexRAN 23.07                      |


### TM500
**Hardware:**
|     Item     | Info                                                     |
|:------------:| -------------------------------------------------------- |
|     CPU      | Intel(R) Xeon(R) CPU E5-2695 v4 @ 2.10GHz (18 cores) x 2 |
|    Memory    | 132GB                                                    |
|     Disk     | 1T                                                       |
|     NIC      | MT27800                                                  |
| Server Model | Supermicro SSG-6028R-E1CR12L                             |

**Software:**
|  **Item**   | **Info**                            |
|:-----------:|:----------------------------------- |
|     OS      | Red Hat Enterprise Linux 9 (RHEL 9) |
|   Kernel    | Linux bell 5.14.0-412.el9.x86_64    |
|  Boot disk  | WDC WD10SPZX-00Z                    | 
| TMA version | NLC 1.4.0                           |

---
## Current status
| Item                                                                     | Status             |
| ------------------------------------------------------------------------ | ------------------ |
| [Bring up TM500](#step12-bring-up-tm500cloudue)                          | :heavy_check_mark: |
| [Check TM500 PTP sync](#step13-tm500-ptp-synchronization)                | :heavy_check_mark: |
| [PTP sync of gNB](#step-32-gnb-ptp-synchronization)                      | :heavy_check_mark: |
| [Bring up gNB](#step-33-run-gnb)                                         | :heavy_check_mark: |
| [RU get on time packet from DU](#step-41-check-du-connection-at-ru-side)   | :heavy_check_mark: |
| [DU get FH packet from RU](#step-42-check-ru-connection-at-du-side)      | :heavy_check_mark: |
| [Run UE](#5-run-uesim)                                                   | :heavy_check_mark: |
| [UE get mib and sib1 for DL sync (cell search fail)](#52-cell-search)    | :heavy_check_mark: |

## Configuration
### Configuration Files
|     | O-DU High                                                                                                                                                                                                                             | O-DU Low                                                                                                                                                                                                          | RUSIM                                                                                                                                                                                                                                                                                              | UESIM                                                                                                                                                                                                                                                                       |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| L2  | [fd_testconfig_tst600.cfg](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20FlexRAN%20and%20Testmac%20configs/600/fd_testconfig_tst600.cfg) | N/A                                                                                                                                                                                                               | N/A                                                                                                                                                                                                                                                                                                | [Configure Radio Contexts](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Integration%20Guide%20of%20TM500%2BFlexRAN%20L1%2Btestmac.md#uesim) |
| L1  | N/A                                                                                                                                                                                                                                   | [xrancfg_sub6.xml](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20FlexRAN%20and%20Testmac%20configs/xrancfg_sub6.xml) | [4x4_9000_testmac.csv](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20TM500%20RU%20and%20UE%20configs/4x4_9000_testmac.csv) | N/A                                                                                                                                                                                                                                                                         |
| FH  | N/A                                                                                                                                                                                                                                   | [xrancfg_sub6.xml](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20FlexRAN%20and%20Testmac%20configs/xrancfg_sub6.xml) | [4x4_9000_testmac.csv](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20TM500%20RU%20and%20UE%20configs/4x4_9000_testmac.csv) | N/A                                                                                                                                                                                                                                                                         |
---

### L2
- File location : `/home/ubuntu/intel_sw/FlexRAN/testcase/fd/mu1_100mhz/600/fd_testconfig_tst600.cfg`

| Parameters                    | value                | config parameter                                                                                                                     |
| ----------------------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| CC config                     | 4x4                  | `<nNrOfTxAnt>4</nNrOfTxAnt>`<br>`<nNrOfRxAnt>4</nNrOfRxAnt>`<br>`<nNrOfDLPorts>4</nNrOfDLPorts>`<br>`<nNrOfULPorts>4</nNrOfULPorts>` |
| DL Point A frequency(ARFCN)   | 3700.56 MHz (646704) | `<nDLAbsFrePointA>3700560</nDLAbsFrePointA>`                                                                                         |
| DL center frequency           | 3749.7  MHz (649980) | Check calculation [here](#DL-center-frequency-calculation)                                                                           |
| SSB frequency                 | 3708.48 MHz (647232) | Check calculation [here](#SSB-center-frequency-calculation)                                                                          |
| System Bandwidth              | 100 MHz              | `<nDLBandwidth>100</nDLBandwidth>`                                                                                                   |
| SCS                           | 30KHZ                | `<nSSBSubcSpacing>1</nSSBSubcSpacing>` <br> 0: Case A 15kHz, 1: Case B 30kHz, 2: Case C 30kHz, 3: Case D 120kHz, 4:Case E 240kHz     |
| SS block pattern              | case B               | `<nSSBSubcSpacing>1</nSSBSubcSpacing>` <br> 0: Case A 15kHz, 1: Case B 30kHz, 2: Case C 30kHz, 3: Case D 120kHz, 4:Case E 240kHz     |
| SSB Period                    | 20ms                 | `<nSSBPeriod>2</nSSBPeriod>` <br> 0: ms5, 1: ms10, 2: ms20, 3: ms40, 4: ms80, 5: ms160                                               |
| dl-UL-TransmissionPeriodicity | 2.5ms                | `<nTddPeriod>5</nTddPeriod>` <br> SCS 30kHz a slot=0.5ms, 5 x 0.5ms = 2.5ms                                                          |
| SSB Subcarrier Offset         | 0                    | `<nSSBSubcOffset>0</nSSBSubcOffset>`                                                                                                 |
| SSB PRB Offset                | 12                   | `<nSSBPrbOffset>12</nSSBPrbOffset>`                                                                                                  | 
| PCI(Physical Cell ID)         | 11                   | `<nPhyCellId>11</nPhyCellId>`                                                                                                        |
| Duplex mode                   | TDD                  | This test case is only for TDD                                                                                                       |
| intraFreqReselection          | allowed              | hardcode in `/home/ubuntu/intel_sw/FlexRAN/testcase/fd/mu1_100mhz/600/s0_txconfig_600.cfg`                                           |
| controlResourceSetZero        | 10                   | hardcode in `/home/ubuntu/intel_sw/FlexRAN/testcase/fd/mu1_100mhz/600/s0_txconfig_600.cfg`                                           |
| searchSpaceZero               | 0                    | hardcode in `/home/ubuntu/intel_sw/FlexRAN/testcase/fd/mu1_100mhz/600/s0_txconfig_600.cfg`                                           |
                                                              |


#### DL center frequency calculation
- SCS 30KHZ, Bandwidth 100 MHz can have 273 PRBs.
> TS 138 101-1 - V17.5.0
![image](https://hackmd.io/_uploads/BJdan_wwJg.png)
- DL center frequency is DL Point A frequency + (273 PRBs ÷ 2)
- 1 PRB has 12 subcarrier, 1 subcarrier = 30 KHZ = 0.03 MHz
- Makes **DL center frequency = DL Point A frequency + (136.5 x 12 x 0.03)** = 3401.58+136.5x12x0.03 = **3450.72 MHz**

#### SSB center frequency calculation
- SSB frequency identifies the position of resource element RE=#0 (subcarrier #0) of resource block RB#10 of the SS block.
- So **SSB frequency=3351.06+24(RB)x12(subcarrier)x0.015(SCS)+0+10(RB)x12(subcarrier)x0.03(SCS)=3358.98 MHz**

> [!TIP]
> ##### Online Tool
> - [NR Reference Point A](https://www.sqimway.com/nr_refA.php): Give DL center frequency, the website will calcualte Point A, and show SSB frequency	with different SC and RB combination.
> - [5G NR ARFCN calculator](https://5g-tools.com/5g-nr-arfcn-calculator/): calculate both Freq to ARFCN and ARFCN to Freq

#### nSSBSubcSpacing
```
0: Case A 15kHz
1: Case B 30kHz
2: Case C 30kHz
3: Case D 120kHz
4: Case E 240kHz
```

TM500 default is case C. If need to use case B, make sure at Init script add:
```
SETP L1_NR_SCS30KHZ_USE_CASE_B_FOR_CELL_SEARCH 1
```
#### nSSBPeriod
```
0: ms5 1: ms10 2: ms20 3: ms40 4: ms80 5: ms160
```

### L1 (FlexRAN) 
- File location : `/FlexRAN/l1/bin/nr5g/gnb/l1/xrancfg_sub6.xml`

| Parameters               | value             | config parameter                                                                                                                                                                                                                                                                                                                                       |
| ------------------------ | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| dl/ul compression method | 9bitBFP Static    | `<xranCompMethod>0</xranCompMethod>`</br>`<xranCompHdrType>1</xranCompHdrType>`</br>`<xraniqWidth>16</xraniqWidth>`</br>`<xranPrachCompMethod>0</xranPrachCompMethod>`</br>`<xranPrachiqWidth>16</xranPrachiqWidth>`</br>`<oRu0PrbElemDl0>0,273,0,14,0,0,0,16,0,0,0</oRu0PrbElemDl0>`</br>`<oRu0PrbElemUl0>0,273,0,14,0,0,0,16,0,0,0</oRu0PrbElemUl0>` |
| DU MAC address           | 00:11:22:33:44:66 | create in `/home/oran/G_O-DU/phy/setupvf.sh`                                                                                                                                                                                                                                                                                                           |
| RU MAC address           | 10:70:fd:14:1c:10 | `<oRuRem0Mac0>10:70:fd:14:1c:10</oRuRem0Mac0>`                                                                                                                                                                                                                                                                                                         |
| MTU size                 | 9000              | `<MTU>9000</MTU>`                                                                                                                                                                                                                                                                                                                                      |
| T1a_min_cp_dl            | 258 μs            | `<T1a_min_cp_dl>258</T1a_min_cp_dl>`                                                                                                                                                                                                                                                                                                                   |
| T1a_max_cp_dl            | 392 μs            | `<T1a_max_cp_dl>392</T1a_max_cp_dl>`                                                                                                                                                                                                                                                                                                                   |
| T1a_min_cp_ul            | 285 μs            | `<T1a_min_cp_ul>285</T1a_min_cp_ul>`                                                                                                                                                                                                                                                                                                                   |
| T1a_max_cp_ul            | 400 μs            | `<T1a_max_cp_ul>400</T1a_max_cp_ul>`                                                                                                                                                                                                                                                                                                                   |
| T1a_min_up               | 155 μs            | `<T1a_min_up>155</T1a_min_up>       `                                                                                                                                                                                                                                                                                                                  |
| T1a_max_up               | 300 μs            | `<T1a_max_up>300</T1a_max_up>      `                                                                                                                                                                                                                                                                                                                   |
| Ta4_min                  | 0 μs              | `<Ta4_min>0</Ta4_min>              `                                                                                                                                                                                                                                                                                                                   |
| Ta4_max                  | 200 μs            | `<Ta4_max>200</Ta4_max>             `                                                                                                                                                                                                                                                                                                                  |
| Tadv_cp_dl               | 125 μs            | `<Tadv_cp_dl>125</Tadv_cp_dl>       `                                                                                                                                                                                                                                                                                                                  |
| T2a_min_cp_dl            | 259 μs            | `<T2a_min_cp_dl>259</T2a_min_cp_dl>`                                                                                                                                                                                                                                                                                                                   |
| T2a_max_cp_dl            | 470 μs            | `<T2a_max_cp_dl>470</T2a_max_cp_dl>`                                                                                                                                                                                                                                                                                                                   |
| T2a_min_cp_ul            | 125 μs            | `<T2a_min_cp_ul>125</T2a_min_cp_ul>`                                                                                                                                                                                                                                                                                                                   |
| T2a_max_cp_ul            | 1200 μs           | `<T2a_max_cp_ul>1200</T2a_max_cp_ul>`                                                                                                                                                                                                                                                                                                                  |
| T2a_min_up               | 70 μs             | `<T2a_min_up>70</T2a_min_up>       `                                                                                                                                                                                                                                                                                                                   |
| T2a_max_up               | 345 μs            | `<T2a_max_up>345</T2a_max_up>      `                                                                                                                                                                                                                                                                                                                   |
| Ta3_min                  | 50 μs             | `<Ta3_min>50</Ta3_min>             `                                                                                                                                                                                                                                                                                                                   |
| Ta3_max                  | 171 μs            | `<Ta3_max>171</Ta3_max>             `                                                                                                                                                                                                                                                                                                                  |
### RUSIM
- File location : `C:\Users\bmwlab\Desktop\viavi cloudue\NLA_7_4_0\TM500_NR_5G_EXT-MUE_Release_NLA_7_4_0_CloudUE\ppc_pq\public\ftp_root\oran_2_0_defaults`

| Parameters    | RUSIM     | config parameter                                                                                                                                               |
| ------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Tadv_cp_dl    | 25000 ns  | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/tcp-adv-dl,SR_UINT32_T`    |
| T2a_min_cp_dl | 285000 ns | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/t2a-min-cp-dl,SR_UINT32_T` |
| T2a_max_cp_dl | 470000 ns | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/t2a-max-cp-dl,SR_UINT32_T` |
| T2a_min_cp_ul | 285000 ns | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/t2a-min-cp-ul,SR_UINT32_T` |
| T2a_max_cp_ul | 429000 ns | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/t2a-max-cp-ul,SR_UINT32_T` |
| T2a_min_up    | 71000 ns  | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/t2a-min-up,SR_UINT32_T`    |
| T2a_max_up    | 429000 ns | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/t2a-max-up,SR_UINT32_T`    |
| Ta3_min       | 20000 ns  | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/ta3-min,SR_UINT32_T`       |
| Ta3_max       | 32000 ns  | `o-ran-delay-management:delay-management/bandwidth-scs-delay-state[bandwidth='100000'][subcarrier-spacing='30000']/ru-delay-profile/ta3-max,SR_UINT32_T`       |

- File location : `\VIAVI\TM500\5G NR - NLC 1.4.0\ppc_pq\public\ftp_root\o-ran.cfg`

| Parameters     | RUSIM             | config parameter                        |
| -------------- | ----------------- |:--------------------------------------- |
| DU MAC address | 00:11:22:33:44:66 | `DefaultDuMacAddress=00:11:22:33:44:66` |


### UESIM
#### Configure Radio Contexts
| Parameters                           | value            |
| ------------------------------------ | ---------------- |
| Duplex                               | TDD              |
| Cell Id                              | 11               |
| Downlink carrier frequency (100 kHz) | 37497   (100kHz) | 
| System bandwidth (MHz)               | 100              |
| AbsoluteFrequencyPointA (100 kHz)    | 37005.6 (100kHz) |
| AbsoluteFrequencySSB (100 kHz)       | 37084.8 (100kHz) |
| Nuber of receive antennas | 4 |

1. Press Edit properties our double click `Configuration Radio Context`

![image](https://hackmd.io/_uploads/B1MZTgI5a.png)

2. Validate the parameter you change then save it.

![image](https://github.com/user-attachments/assets/146c152c-2175-428a-983f-54eb995727df)

![image](https://github.com/user-attachments/assets/4149799f-6a22-4782-9955-ef22395d1653)

## L2/L1/RU/UE Parameter Table
| Parameter                      | L2 Value             | L1 Value          | RU (RUSIM - oran_2_0_defaults) | UE (UESIM - Configure Radio Contexts) |
| ------------------------------ | -------------------- | ----------------- | ------------------------------ | ------------------------------------- |
| **Duplex Mode**                | TDD                  | -                 | TDD                            | TDD                                   |
| **Cell ID (PCI)**              | 11                   | -                 | -                              | 11                                    |
| **Downlink Carrier Frequency** | 3749.7 MHz (649980)  | -                 | -                              | 37497 (100kHz)                        |
| **System Bandwidth**           | 100 MHz              | -                 | 100000 (Hz)                    | 100 MHz                               |
| **Point A Frequency**          | 3700.56 MHz (646704) | -                 | -                              | 37005.6 (x 100kHz = 3700.56 MHz)      |
| **SSB Frequency**              | 3708.48 MHz (647232) | -                 | -                              | 37084.8 (x 100kHz = 3708.48 MHz)      |
| **SCS (for SSB)**              | 30 kHz (Case B)      | -                 | 30000 (Hz)                     | -                                     |
| **SSB Period**                 | 20 ms                | -                 | -                              | -                                     |
| **SSB Subcarrier Offset**      | 0                    | -                 | -                              | -                                     |
| **SSB PRB Offset**             | 12                   | -                 | -                              | -                                     |
| **Number of Rx Antennas**      | 4                    | 4                 | -                              | 4                                     |
| **Number of Tx Antennas**      | 4                    | 4                 | -                              | -                                     |
| **Number of DL Ports**         | 4                    | 4                 | -                              | -                                     |
| **Number of UL Ports**         | 4                    | 4                 | -                              | -                                     |
| **VLAN ID**                    | 5                    | -                 | 5                              | -                                     |
| **PDSCH/PUSCH EAXCID**         | -                    | 0, 1              | 0, 1                           | -                                     |
| **PRACH EAXCID**               | -                    | 2, 3              | 2, 3                           | -                                     |
| **DL/UL Compression**          | -                    | 9bit BFP Static   | 9bit static                    | -                                     |
| **DU MAC Address**             | -                    | 00:11:22:33:44:66 | 00:11:22:33:44:66              | -                                     |
| **RU MAC Address**             | -                    | 10:70:fd:14:1c:10 | 10:70:fd:14:1c:10              | -                                     |
| **MTU Size**                   | -                    | 9000              | 9000                           | -                                     |
| **Tadv_cp_dl**                 | -                    | 125               | 25000 ns (25 μs)               | -                                     |
| **T2a_min_cp_dl**              | -                    | 259               | 285000 ns (285 μs)             | -                                     |
| **T2a_max_cp_dl**              | -                    | 470               | 470000 ns (470 μs)             | -                                     |
| **T2a_min_cp_ul**              | -                    | 125               | 285000 ns (285 μs)             | -                                     |
| **T2a_max_cp_ul**              | -                    | 1200              | 429000 ns (429 μs)             | -                                     |
| **T2a_min_up**                 | -                    | 155               | 71000 ns (71 μs)               | -                                     |
| **T2a_max_up**                 | -                    | 300               | 429000 ns (429 μs)             | -                                     |
| **Ta3_min**                    | -                    | 50                | 20000 ns (20 μs)               | -                                     |
| **Ta3_max**                    | -                    | 171               | 32000 ns (32 μs)               | -                                     |


## Run Application
## 1. TM500 Status
### Step1.1 Configure TM500
For this integration, we're using a [CSV file](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Intel%20TM500%20RU%20and%20UE%20configs/TM500%20RU%20and%20UE%20configs/oran_2_0_defaults.csv) provided by Intel. To better identify it, we've changed the filename to '[4x4_9000_testmac.csv](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20TM500%20RU%20and%20UE%20configs/4x4_9000_testmac.csv)'."
### Step1.2 Bring up TM500(cloudUE)
- In Control PC, use SSH to access TM500 server(192.168.8.67).

![image](https://hackmd.io/_uploads/B13RcGuaT.png)

- Fill in FTP_USER and ETH0_ADDR in `cuedock.yaml`.
```bash=
cd installcue/
vim cuedock.yaml
FTP_ADDR = 192.168.8.68 // control PC IP
ETH0_ADDR = 192.168.8.67 // cloudUE ETH0 IP
```
- start docker and run up cloudUE
```bash=
# start docker
sudo systemctl start docker

# Install cloudUE on docker:
cd installcue/
sudo docker compose -f cuedock.yaml up -d
```
![image](https://hackmd.io/_uploads/BkzASkg5T.png)
- check cloudUE container is running up properly
```bash=
sudo docker ps
```
![image](https://hackmd.io/_uploads/HkYqIPHC6.png)

- Then you can telnet to TM500(192.168.8.67) to see the log.

![image](https://hackmd.io/_uploads/BkNvkqMY6.png)

- If you get crash dump you can try to restart docker.
```bash=
# Remove cloudUE from docker:
sudo docker compose -f cuedock.yaml down
```
- After remove you need to bring up cloudue again
```bash=
sudo docker compose -f cuedock.yaml up -d
```
- Make licience up
```bash=
sudo docker ps
sudo docker exec -it  <container id> /bin/bash
rm -rf sda1
exit
```
### Step1.3 TM500 PTP Synchronization
>Check in control PC telnet window
- PTP in TM500 will sync automatically. If you see the log below it sync successfully.

![image](https://hackmd.io/_uploads/Hk9-uTgqT.png)

### Step1.4 Use TMA to control TM500
### Connection with TM500
![image](https://hackmd.io/_uploads/Byq1Lye9a.png)

#### Wait until you see this log stop in ==telnet== window, you can use TMA to connect TM500.
- Click TMA icon in control PC, it is in the path of `C:\Program Files (x86)\VIAVI\TM500\5G NR - NLC 1.4.0\Test Mobile Application/TMA`

![image](https://hackmd.io/_uploads/H1D5mq3o6.png)
- Chose EXT-MUE then click start TMA.

![image](https://hackmd.io/_uploads/S12zVc2sT.png)


## 2. Run TM500
### Step2.1 Set csv files
Put two configuration(`o-ran.cfg` and `4x4_9000_testmac.csv`) under the path `C:\Users\bmwlab\Desktop\viavi cloudue\NLA_7_4_0\TM500_NR_5G_EXT-MUE_Release_NLA_7_4_0_CloudUE\ppc_pq\public\ftp_root`
![image](https://hackmd.io/_uploads/HkeDS9U6np.png)

> [!NOTE]  
> If you edit 4x4_9000_testmac.csv. Remember to reboot TM500.

### (Opt)New Session
- click the top part main menu "Session" > "New Session"

<br>

![image](https://hackmd.io/_uploads/BJBDIWaeR.png)

<br>

- or use window controls + w 

	- can check using session time in "Current Session" next to bottom part "Command  Line"
	- right click in Command Line window > Clear can clean up the log
	- If you don't need to catch measurement log then don't need to do this step.

### Step2.2 Connect TM500
Press top-left corner green key to connect TM500.
![image](https://hackmd.io/_uploads/SyJOtnzap.png)

### Step2.3 TM500 Connect Preference
#### Configuration Set to "No Configuration"
"Connection" > "Configuration" > "Configuration" > **"No Configuration"**
![image](https://github.com/user-attachments/assets/82d6ad4e-39ae-4ef4-80f7-ab1ad813dc20)

<br>

Due to [ORAN - ORU Setting RUName Setting Issue](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Troubleshoot%20of%20TM500%2BFlexRAN%2Btestmac.md#tm500-runame-settin). We need to use "No Configuration" and manually command the setting. If want to use 2x2, can use MTS Mode and skip step "[4.2 Command the following in TM500](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Integration%20Guide%20of%20TM500%2BFlexRAN%20L1%2Btestmac.md#42-command-the-following-in-tm500)" to "[4.4 set eth2 to 9000](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Integration%20Guide%20of%20TM500%2BFlexRAN%20L1%2Btestmac.md#44-set-eth2-to-9000)".

#### TCP/IP Address Set to TM500 Server(192.168.8.67)
"Connection" > "Setup" > "Test Mobile TCP/IP Setting" > "IP Address" > **"192.168.8.67"**

![image](https://hackmd.io/_uploads/SJUV_3MpT.png)

#### Radio Card Setting
- "Connection" > "Radio Card" > "Radio Card Settings" > "I/F Mode" > **"ORAN"**
- If it is FH mode. Will run RUSIM.

<br>

![image](https://hackmd.io/_uploads/rypfBZ2x0.png)

- If your want to use 4x4 then need to click "Selected" of two radio cards , 2x2 click one

<br>

![image](https://hackmd.io/_uploads/HkO1kHgha.png)

- Select `SubCarrier Spacing` and `Radio Bandwidth` for radio card based on your [configuration](#configuration)
- in this integration `SubCarrier Spacing` = **30kHz**, `Radio Bandwidth` = 100 **MHZ**

<br>

![image](https://hackmd.io/_uploads/HJUTfVg3a.png)

#### Press bottom-right OK

![image](https://hackmd.io/_uploads/BJMqt6fpT.png)

### Step2.3 Manually Set Configuration with Command
#### Wait the logs "Waiting for User to Configure Test Mobile" and "GSTS 0x00 Ok Reset" show

<br>

![image](https://github.com/user-attachments/assets/bb28a92a-d6be-4c8a-a876-4ba6995fc2ab)

#### Command the following in TM500:
```
MULT STANDALONE
CONF ORU
SCXT 0 NR
SELR 0 FES-0 ORU1-P1 0 ORAN ORU4x4
ADDR 0 FES-0 ORU1-P1
CFGR 0 SCS 1
CONF ORU ORU4x4 DuMacAddress 00:11:22:33:44:66
CONF ORU ORU4x4 SysrepoInitFile 4x4_9000_testmac.csv
CONF ORU ORU4x4 MtuOverride 9000
CONF ORU ORU4x4
GETR
GSTS
LGPC
SCFG MTS_MODE
```
#### Wait the log "CU PLANE ACTIVE" shows
will takes some times

<br>

![image](https://github.com/user-attachments/assets/f84401dd-1209-45a7-bab5-3b7a2cf956aa)

<br>

Command the following in TM500:
```
STRT
```
This will makes TM500 freeze for a little while

<br>

![image](https://github.com/user-attachments/assets/d3e05f14-4b85-41e8-a1d4-0e5dab00f9ba)

<br>

Command the following in TM500:
```
GSTS
GVER
```

## (Opt) Measurement log
### Logging Controller
This window will only show content and allow interaction after the TM500 has finished connecting
- For each log, there are two options: "log" or "view".
	- When "log" is selected, the related log information will be recorded in a file.
	- When "view" is selected, the related log information will be displayed in the TMA interface.
- Default only has Protocol logs

![image](https://hackmd.io/_uploads/r1oIsbTgR.png)

### Start Logging
Click the red dot around top-left
![image](https://hackmd.io/_uploads/Hy9KIi3e0.png)

### Stop Logging
Click the red square beside the red dot. You can stop log collecting at any time when the E2E process ends or when enough of the necessary logs have been gathered.

### Convert Data
1. Click the `Convert Saved Data` in the toolbar at the top.

![image](https://github.com/user-attachments/assets/9fe83314-0bcf-4de4-8bd1-10a75c534f2e)

2. Click Convert

![image](https://github.com/user-attachments/assets/a440b11c-ee8f-44b8-b45e-ae8a14341459)

The progress will show under `Convert Saved Data` icon or by logs in `Command Line`

![image](https://github.com/user-attachments/assets/717609ae-9fa1-4238-8957-a5df39dd71bd)

Finished converted files are located at `C:\Users\bmwlab\Documents\VIAVI\TM500\5G NR\Test Mobile Application\Logged Data\YYMMDD_HHMMSS_session\YYMMDD_HHMMSS`




## 3. Bring up gNB
<!-- TOC --><a name="step-31-configure-gnb"></a>
### Step 3.1 Configure gNB

### Step 3.2 gNB PTP synchronization
#### method 1. Run in System
If PTP is already configured as a system service, use the following commands to check its status.
```bash=
sudo journalctl -u ptp4l -f
sudo journalctl -u phc2sys -f
```
ptp4l rms < 100 and phc2sys phc offset < 100 represent sync
- ptp4l 

<br>

![image](https://github.com/user-attachments/assets/08db450c-d084-4a39-9e56-a4519272fb1a)

<br>

- phc2sys

<br>

![image](https://github.com/user-attachments/assets/de766b24-e0b9-4f27-92fb-367c969894ca)

<br>

guide of ptp run in system see [here](https://hackmd.io/@Spinnefarn/SJFvKX8ma#12-Time-Syncronization-PTP)

##### Troubleshott: phc2sys.service failed

This shows phc2sys.service active failed, use the below command to restart phc2sys.service
```
systemctl start phc2sys.service 
```
Keep checking phc2sys status until phc offset < 100. This may takes time.
#### method 2. Manually
```bash=
// Ternimal 1 - Run ptp4l
sudo ptp4l -i ens1f1 -m -H -2 -s -f /etc/ptp4l.conf

// wait ptp4l rms < 100 and create a new terminal window

// Ternimal 2 - Run phc2sys
sudo phc2sys -w -m -s ens1f1 -R 8 -f /etc/ptp4l.conf
```
ptp4l rms < 100 and phc2sys phc offset < 100 represent sync
- ptp4l

<br>

![image](https://github.com/user-attachments/assets/ed1e6c24-1fa6-4449-a23d-2e0fe9e7348d)

<br>

- phc2sys

<br>

![image](https://github.com/user-attachments/assets/1ddcdde6-7b45-4108-9cb0-53c4556ad80a)

<br>


### Step 3.3 Run gNB
> [!TIP]
> Following commands only need to do once each time run the server.
> 1. Set HW Accelerator to DPDK
> ```bash
> cd 
> sudo ./ini.sh
> ```
> 2. Set the virtual function to DPDK
>```bash
> # Create VF and bind VF with DPDK
> cd ~/intel_sw/phy
> sudo su
> ./cvl.sh
> exit
> ```
> See the content of `cvl.sh` [here](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/cvl.sh)
> 
> 3. set realtime
> ```bash
> sudo tuned-adm profile realtime
> ```

To capture the console log, use MobaXterm instead of VS Code. After FlexRAN and testmac have stopped running, click "Terminal" in the top-left corner, then select "Save terminal text." While FlexRAN and testmac can automatically generate log files such as 'phy_tracelog_wls0.txt' and 'testmac_tracelog_wls0.txt', these files don't contain the complete logs.

#### 1. FlexRAN
```bash=
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/
source ../../../../../../phy/setupenv.sh 
./l1.sh -xran
```
**Wait belows logs show:**
```
'''
L1 start tick is 1420814686800159
step  1 end tick[1420817993294819], used time[2363.470215(ms)]
step  2 end tick[1420822824888853], used time[3453.605225(ms)]
step  3 end tick[1420827714811245], used time[3495.298096(ms)]
total elapsed time [9312.373000(ms)]

PHY>welcome to application console
```
#### 2. testmac
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

Or, if you have a test file like "[sprsp_mcc_mu1_100mhz_4x4_hton.cfg](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/NTUST%20FlexRAN%20and%20Testmac%20configs/sprsp_mcc_mu1_100mhz_4x4_hton.cfg)" at `/home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/testmac`, you can use the command below:
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/testmac
source ../../../../../../phy/setupenv.sh 
./l2.sh --testfile=sprsp_mcc_mu1_100mhz_4x4_hton.cfg
```

## 4. Interoperability between DU and RU
### Step 4.1 Check DU connection at RU side
In TM500 command:
```
FORW MTE GETRUSTATS
```
Make sure there is no too much early and late packet 

<br>

![image](https://github.com/user-attachments/assets/cb9af23f-f803-4c05-8cfd-9790e96ca462)

### Step 4.2 Check RU connection at DU side

- The packet count in FlexRan log should increase.

## [Opt]Catch PCAP in TM500

### using dpdk_cap()

1. Telnet to the FH Server port 23

2. command dpdk_cap(`<index>`, `<cap_size_in_mb>`) and CTRL + ENTER in telnet command line

- Format : dpdk_cap(`<index>`, `<cap_size_in_mb>`)

	- `<index>` is the eth port eth2=0, eth3=1

	- `<cap_size_in_mb>` is the total size to capture

	- example : dpdk_cap(0,1000), captures 1000MB files from eth2

#### 3. Log will save in folder

- path : `\VIAVI\TM500\5G NR - NLC 1.4.0\ppc_pq\public\ftp_root\`



![image](https://hackmd.io/_uploads/S1f8Aqu5p.png)


## 5. Run UESIM
### 5.1 Init
"Test Manager" > "My Tests" > "testmac" > "Init" > "Run"

<br>

![image](https://github.com/user-attachments/assets/db63933e-7d5b-4262-a2ae-6d9186fe811a)

<br>

Make sure click the script "Init" > "Intel version Initial"

### (Opt) Capture MUX Log
"Test Manager" > "My Tests" > "testmac" > "MUX_LOG" > "Run"

<br>

![image](https://github.com/user-attachments/assets/fa3c8da4-8677-4156-933f-0041e0e216f9)

<br>

Make sure click the scripts "MUX_LOG" > "OFF" and one of MUX Log script under "MUX_LOG"

- "MUX_LOG" > "SIB1 PDSCH CRC Failure"
```
#$$SET_DEBUG_LOG_PREFERENCES 0 [] [3{DBG_1 3(ladd hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00006400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x03E00000 0x00103020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00000020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_2 3(ladd dbg_2 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00006400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x03E00000 0x00103020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00000020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_3 3(ladd dbg_2 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00006400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x03E00000 0x00103020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00000020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)}]
#$$START_DEBUG_LOGGING
```

- "MUX_LOG" > "SIB1 PDSCH CRC Failure"
```
#$$SET_DEBUG_LOG_PREFERENCES 0 [] [3{DBG_2 3(lcfg dbg_2 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00050020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00004020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_3 3(lcfg dbg_3 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00A00000 0x00003004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_1 3(lcfg hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00007420 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000002 0 0x00000015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)}]
#$$START_DEBUG_LOGGING
```
### 5.2 Cell Search
"Test Manager" > "My Tests" > "testmac" > "Cell Search and UE Configure" > "Configuration Radio Contexts" >  "Run"

<br>

![image](https://github.com/user-attachments/assets/0800a751-92ca-4da4-9b9d-dcbb7f107612)

<br>

#### Result
![image](https://github.com/user-attachments/assets/d9d638bc-11fa-4798-bc6c-d56084d9bac8)

<br>

TM500 Command Line:

```
20/05/25 17:20:47:256 C: FORW 0x00 Ok MTE NRPHYCALIBRATEULPOWERSCALING: RETURN CODE:0 SUCCEEDED
```

If [protocol logs](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Integration%20Guide%20of%20TM500%2BFlexRAN%2Btestmac.md#opt-measurement-log) are captured, we can see received MIB and SIB1 show in right side "Protocol View".

These content should match [Intel provide logs](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Intel%20TM500_log/TM500-5G-SCS1_PROT_LOG_NAS_RRC_ALL.log)

## Appendix
### API Log
1. Open Info Trace Tool
> /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/phycfg_xran.xml
```
    <InfoTraceTool>
        <!-- If this is set to 1, Info Trace Tool will be enable, 0 means disable -->
        <nInfoTraceToolEn>1</nInfoTraceToolEn>
```
2. Select Channel
Here take PDSCH as example:
> /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/phycfg_xran.xml
```
 <!-- If this is set to 1, Info Trace Tool will catch PDSCH payload APIs, 0 means won't catch -->
        <nApisPdschPayloadEn>1</nApisPdschPayloadEn>
```
2. Capture pcap
use the command: 
```
tcpdump -i any -w api.pcap
```
4. Turn off Info Trace Tool
> /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/phycfg_xran.xml
```
    <InfoTraceTool>
        <!-- If this is set to 1, Info Trace Tool will be enable, 0 means disable -->
        <nInfoTraceToolEn>0</nInfoTraceToolEn>
```

### FlexRAN FH pcap
1. Change Cable from Switch to a Server
![image](https://github.com/user-attachments/assets/433121cd-dd81-4eae-bf89-f339354d1b3d)

2. Change Destination MAC Address to that Server
> /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/xrancfg_sub6.xml
```
    <!-- remote O-RU 0 Eth Link 0 VF0, VF1-->
    <oRuRem0Mac0>40:a6:b7:92:c4:75</oRuRem0Mac0>
```
3. MTU Size
Change MTU size of that server to 9000
```
sudo ip link set dev enp59s0f1 mtu 9000
```
2. Capture pcap in the Server
```
sudo tcpdump -i enp59s0f1 -w /home/FH.pcap -vv
```
Only capture for seconds, otherwise the pcap file will be large.

### SIB1
SIB1 payload from "sib1.txt" was fed into "s0_txconfig_600.cfg" every other frame at the 1st slot.
>  /home/ubuntu/intel_sw/FlexRAN/testcase/fd/mu1_100mhz/600/s0_txconfig_600.cfg
```
		<MacData0>sib1.txt</MacData0>
	</DL_SCH_PDU1>
```
Full s0_txconfig_600.cfg and sib1.txt see [here](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/tree/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/600) 

### Comapre with OAI
#### Run OAI 4x4
1. [When Connect TM500](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Integration%20Guide%20of%20TM500%2BFlexRAN%20L1%2Btestmac.md#command-the-following-in-tm500), change [command "CONF ORU ORU4x4 SysrepoInitFile 4x4_9000_testmac.csv"](https://github.com/bmw-ece-ntust/sheryl-e2e-integrations/blob/master/TM500%20%2B%20FlexRAN%20%2B%20xFAPI%20%2B%20O-DU%20HIGH%20%2B%20OAI%20CU/1.%20TM500%2BFlexRAN%2Btestmac/Integration%20Guide%20of%20TM500%2BFlexRAN%20L1%2Btestmac.md#command-the-following-in-tm500) to "CONF ORU ORU4x4 SysrepoInitFile oran_oai_tm500_4x4.csv"
2. take off "SETP L1_NR_SCS30KHZ_USE_CASE_B_FOR_CELL_SEARCH 1" in init scipt <br>
3. run OAI with command:
```
cd /home/oai72/FH_7.2_dev/openairinterface5g/cmake_targets/ran_build/build
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/gnb.sa.band78.273prb.fhi72.4x4-TM500_sheryl.conf --sa --reorder-thread-disable 1 --thread-pool 1,3,5,7,9,11,13,15
```
4. the rest steps is same as TM500+OAI

### Constellation Diagram
1. Capture MUX Log 
To capture the MUX log, use the following script:
- PBCH
```
#$$SET_DEBUG_LOG_PREFERENCES 0 [] [3{DBG_2 3(ladd dbg_2 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x0A000000 0x00000002 0 0 0 0 0 0 0x00000001 0 0 0 0 0 0 0 0 0 0x00000080 0x00002000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_3 3(ladd dbg_3 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000210 0x40000380 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_1 3(ladd hlc all  0 0 0 0 0x00028000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00004400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x0000000B 0x00000001 0 0 0 0 0 0 0 0x00000006 0 0 0 0 0 0 0 0 0 0 0x00010000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)}]

#$$START_DEBUG_LOGGING
```
- PDSCH
```
#$$SET_DEBUG_LOG_PREFERENCES 0 [] [3{DBG_1 3(ladd hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00006400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x03E00000 0x00103020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00000020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_2 3(ladd dbg_2 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00006400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x03E00000 0x00103020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00000020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0),DBG_3 3(ladd dbg_2 hlc all  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x00000060 0 0x00006400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0x03E00000 0x00103020 0 0 0x00000E1E 0 0 0 0 0 0 0 0 0x00000020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)}]
#$$START_DEBUG_LOGGING
```
How to capture the MUX Log see [here](#opt-capture-mux-log)

2. Filter out logs
From the file "YYYYMMDD_XXXXXX_CHASSIS0_DBG_3_1" or "YYYYMMDD_XXXXXX_CHASSIS0_DBG_2_1", extract lines containing “LOG_NR_L0_DL_SRP_[channel]_EQ_DATA” and save them to a text file.
You can use the Python tool provided below, or any other method of your choice. 
```py=
def extract_pbch_logs(input_file, output_file):
    """
    Extracts lines containing "PBCH_EQ_DATA" from an input log file and saves them to an output file.

    Args:
        input_file: Path to the input log file.
        output_file: Path to the output file where extracted lines will be saved.
    """
    try:
        with open(input_file, 'r', encoding='utf-8') as infile, open(output_file, 'w', encoding='utf-8') as outfile:
            for line in infile:
                if "PBCH_EQ_DATA" in line:
                    outfile.write(line)
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")


# Example usage:
input_log_file = "20250224_163146_CHASSIS0_DBG_3_1.txt"  # Replace with your input log file path
output_txt_file = "pbch_logs.txt"  # Replace with desired output file path

extract_pbch_logs(input_log_file, output_txt_file)
```

3. Draw constellation diagram
- Click `plot_const` at path `C:\Users\bmwlab\Desktop\Plot Constellation-20250225T015740Z-001\Plot Constellation`. 
![image](https://hackmd.io/_uploads/HJUKi259ye.png)
- In the `Data Keyword` field, enter:
```
LOG_NR_L0_DL_SRP_[channel]_EQ_DATA
```
- Click `Plot File` and select "pbch_logs.txt" generate by step 2

4. Result
<br>

![image](https://hackmd.io/_uploads/ryVw33q5yx.png)
![image](https://hackmd.io/_uploads/HknPh3c5yx.png)






    
