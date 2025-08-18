# Ubuntu Server Boot Error Diagnostic Notes (maxwell)

> Date: 2025-07-22  
> Server IP: 192.168.8.76  
> User: ubuntu@maxwell  
> Issue:  
> 1. After running `ifconfig`, no network card is shown. The server is currently unable to connect to the network.  
> 2. "Settings" icon missing error.  

---
- Issue
   - [Issue 1: No network card displayed after `ifconfig`](#1-issue-1-no-network-card-displayed-after-ifconfig)
      - [Troubleshooting Steps](#12--troubleshooting-steps)
   - [Issue 2 Errors & Warnings (in kernel)](#2-issue-2--errors--warnings-in-kernel)
   - [3 Vendor Report & Processing (SuperMicro)](#3-vendor-report--processing-supermicro)
      - [3.1 Required Information Part 1](#31-required-information-part-1)
      - [3.2 Required Information Part 2](#32-required-information-part-2)
      - [3.3 Required Information Part 3 - Hardware Diagnostic (DOS) Result (.pdf)](#33-required-information-part-3---hardware-diagnostic-dos-result-pdf)
   - [4 . SuperMicro's conclusion](#4--supermicros-conclusion)
   - [5 . How to Re-install OS](#5--how-to-re-install-os)
   - [6 .Current Progress](#6-current-progress)  
---

## 1 Issue 1: No network card displayed after `ifconfig`
<img width="731" height="401" alt="image" src="https://github.com/user-attachments/assets/f69b33fd-be66-467b-b4c4-5d470d3f0339" />

### 1.2 🛠 Troubleshooting Steps
I tried sharing my phone’s internet using a USB connection (since I needed to go to the IA). I ruled out the possibility of a port issue. This could also help confirm if the network card is malfunctioning.  
----> The server could not connect to my phone’s internet.

---

## 2 Issue 2 📸 Errors & Warnings (in kernel)

1. `journalctl -b -p err`  
   <img width="1774" height="1009" alt="screenshot" src="https://github.com/user-attachments/assets/37ee7334-e6b1-45d2-a8b3-4627195e9a8f" />

2. `journalctl -b -p warning`  
   <img width="1796" height="1049" alt="screenshot" src="https://github.com/user-attachments/assets/38b01069-0705-4a5a-93f7-57b188793f6b" />

3. `systemctl status dbus.service`  
   <img width="1776" height="980" alt="image" src="https://github.com/user-attachments/assets/b12f81dd-e344-47ea-97cf-f01ae434595b" />

---

## 3 Vendor Report & Processing (SuperMicro)
**Information we must provide**
|       Item        |  Status     |
|:-----------------:|:-----------:|
| NIC model         |     ✅      |
| dmesg.txt         |     ✅      |
| Server info (.docx)|    ✅      |
| Hardware diagnostics (.pdf) | ✅ |

### 3.1 Required Information Part 1

NIC Model  
<img width="1022" height="175" alt="image" src="https://github.com/user-attachments/assets/0aac7dc9-cdd7-4673-a063-9a4e8fe520e3" />

### 3.2 Required Information Part 2
> [!TIP]  
> Please take screenshots of the specified pages and compile them into a Word file (`.docx`). Submit the Word file together with `dmesg.txt` to the vendor.

**The OS requires the following information:**  
- (1) Kernel version, command:  

```
uname -a
```
Example output:  

<img width="865" height="73" alt="image" src="https://github.com/user-attachments/assets/49b0d1b8-76d4-4561-b0fa-d617a320ba58" />

- (2) Collect `dmesg` log (save the entire output as `.txt`):  

```
sudo dmesg
```

- (3) Syslog (last 5 lines):  
```
tail -n 5 /var/log/syslog
```

<img width="865" height="102" alt="image" src="https://github.com/user-attachments/assets/a74f8445-86e8-4051-93f8-67776be1f73c" />

**BIOS & BMC**  
No server restart required. If BMC is configured, log in via GUI:  
- (4) Web interface example:  
<img width="752" height="370" alt="image" src="https://github.com/user-attachments/assets/20326382-9963-41b7-9db9-c1ba8f051c5c" />

- (5) Navigate to: **System → Component Info → NETWORK AOC**  
Check if hardware detects any NIC MAC addresses.  

<img width="865" height="243" alt="image" src="https://github.com/user-attachments/assets/a0868afd-a21d-469a-971f-5fb5282d7a93" />

- (6) Health Event Log:  
<img width="865" height="557" alt="image" src="https://github.com/user-attachments/assets/3d052a74-8cc7-426d-9a7d-550585153f27" />

---

### 3.3 Required Information Part 3 - Hardware Diagnostic (DOS) Result (.pdf)

#### 3.3.1 Download SDO

Requires SuperMicro account registration & 1 USB drive.  
- SDO download link: https://www.supermicro.com/zh_tw/support/resources/downloadcenter/smsdownload?category=SDO

<img width="1637" height="557" alt="image" src="https://github.com/user-attachments/assets/fef30e91-c6c9-455d-b1a9-fb555f4a82e3" />

- After downloading, copy the **X86** folder contents to the USB root directory.  
<img width="1598" height="542" alt="image" src="https://github.com/user-attachments/assets/2d22d4e2-9758-4447-b304-5b4b3eb56b3d" />

#### 3.3.2 Start DOS Diagnostics (on Server)

- Fully power off server (not reboot).  
- Insert SDO USB, power on, press `DELETE` repeatedly to enter BIOS, then press `F11`.  

<img width="1583" height="852" alt="image" src="https://github.com/user-attachments/assets/6f42f52e-5f93-49fa-be38-bda61b6ee0d4" />

- Select **UEFI Built-in EFI Shell**.  
<img width="1052" height="686" alt="image" src="https://github.com/user-attachments/assets/034f1bcf-1160-4dae-b371-0c22b9206a31" />

- Run:

ESC → fs0:


<img width="1562" height="467" alt="image" src="https://github.com/user-attachments/assets/2ede1c4e-16f2-4341-9651-8d1bfd68422c" />

- Execute:

SuperDiag.efi /full


<img width="1585" height="566" alt="image" src="https://github.com/user-attachments/assets/3f6e3352-d45e-4e45-95e8-5e3a4f774893" />  
<img width="1590" height="276" alt="image" src="https://github.com/user-attachments/assets/60909108-c44b-44d5-bd85-d0e46319adc3" />

- After test finishes:  
<img width="1601" height="617" alt="image" src="https://github.com/user-attachments/assets/ae2032b0-97dc-4855-a573-c3bd726dadfb" />

- Tool generates a folder on USB containing board name, serial number, and timestamp. Logs include `.html` summary.  
**Submit the result as `.pdf` file**.  

<img width="1615" height="260" alt="image" src="https://github.com/user-attachments/assets/27f60d41-fd84-4b25-befd-4856f9be7f94" />  
<img width="1680" height="915" alt="image" src="https://github.com/user-attachments/assets/9fc9e431-c5fd-448d-b777-5b267ccacc80" />

---
## 4 . SuperMicro's conclusion

- The hardware in the server is healthy.

- Next step : Reinstall server 


---

## 5 . How to Re-install OS 
> [!TIP]  
> No need for a new hard drive. Just prepare an Ubuntu USB and follow these steps.

- Fully power off the server (not reboot).  
- Insert Ubuntu USB, power on, press `DELETE` to enter BIOS Setup.  

- Go to **Boot** and ensure Ubuntu USB is set as first boot option.  

<img width="1023" height="816" alt="screenshot" src="https://github.com/user-attachments/assets/445dadd6-3a78-4412-917e-7d6f2762e8eb" />

> [!NOTE]  
> If Ubuntu USB is not the first boot option:  
> Use arrow keys + `Enter` → choose Ubuntu USB in menu → "Yes" → Save & Exit with `F4`.

- Exit & Save with `F4`.  
- System should boot into Ubuntu installer.  
- If it returns to BIOS, USB boot failed.  

> [!NOTE]  
> If USB boot fails, try: `F11` → Boot Menu → "USB".

---

# 6 .Current Progress 
- Re-install completed.  
- NIC restored. Current Server IP: 192.168.8.76 (verified).  
- "Settings" function working properly.  

![1234](https://github.com/user-attachments/assets/6db37f74-7a2c-46a7-b1b8-162bb2d05203)  
![123](https://github.com/user-attachments/assets/409f7fcb-d71c-4b4a-b0cd-ed033f8913b8)  
