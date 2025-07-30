# Ubuntu Server 啟動錯誤診斷筆記（maxwell）

> 日期：2025-07-22  
> Server IP：192.168.8.76  
> 使用者：ubuntu@maxwell  
> Issue：
> 1. Server 在ifconfig 後沒有顯示網卡，server 目前無法連接上網路
> 2. 「Settings」圖示消失的錯誤情形

---
## 1 Issue 1 Server 在ifconfig 後沒有顯示網卡
<img width="731" height="401" alt="image" src="https://github.com/user-attachments/assets/f69b33fd-be66-467b-b4c4-5d470d3f0339" />

### 1.2 🛠 嘗試處理步驟
I try sharing my phone's internet using a USB connection (I need to go to the IA). I've ruled out the possibility that it's a port issue. This can also help confirm whether the network card is malfunctioning.
----> The server cannot connect to my phone's internet.

## 2 Issue 2 📸 錯誤與警告截圖 ( in kernel )

1. `journalctl -b -p err`  
   <img width="1774" height="1009" alt="螢幕擷取畫面 2025-07-22 131538" src="https://github.com/user-attachments/assets/37ee7334-e6b1-45d2-a8b3-4627195e9a8f" />

2. `journalctl -b -p warning`  
   <img width="1796" height="1049" alt="螢幕擷取畫面 2025-07-22 131612" src="https://github.com/user-attachments/assets/38b01069-0705-4a5a-93f7-57b188793f6b" />

3. `systemctl status dbus.service`  
   <img width="1776" height="980" alt="image" src="https://github.com/user-attachments/assets/b12f81dd-e344-47ea-97cf-f01ae434595b" />

---

## 3 廠商回報與處理 ( SuperMicro )
**我方須提供的資料**
|       項目        |  是否完成     |
|:-----------------:|:------------:|
|    網卡型號        |     ✅      |
|     dmesg.txt     |     ✅      |
| server 資訊 (.docx)|     ✅      |
| 硬體診斷結果 (.pdf) |     ✅      |


### 3.1 我方須提供的資料 part 1

網卡型號 
<img width="1022" height="175" alt="image" src="https://github.com/user-attachments/assets/0aac7dc9-cdd7-4673-a063-9a4e8fe520e3" />

### 3.2 我方須提供的資料 part 2
> [!TIP]
> 請將以下指定畫面截圖並整理成一份 word 檔(`.docx`) ，將`word檔`和`dmesg.txt`兩份文件回報給廠商


**The OS requires you to provide information :** 
- (1) Kernel version , use command : uname -a  \
Can get information like this .

<pr>

<img width="865" height="73" alt="image" src="https://github.com/user-attachments/assets/49b0d1b8-76d4-4561-b0fa-d617a320ba58" />

<pr>

- (2) Need to get dmesg message (please save all dmesg as a `.txt` )
```
sudo dmesg
```

- (3) syslog  
```
tail -n 5 /var/log/syslog
```
<pr>
   
<img width="865" height="102" alt="image" src="https://github.com/user-attachments/assets/a74f8445-86e8-4051-93f8-67776be1f73c" />

<pr>

**BIOS & BMC**  \
No need to restart the server , If the BMC connection is set, log in to the GUI 
- (4) using the Web interface and you will get the following screen: 
<pr>

<img width="752" height="370" alt="image" src="https://github.com/user-attachments/assets/20326382-9963-41b7-9db9-c1ba8f051c5c" />

<pr>

- (5) Then go to this page : System ==> Component Info ==> NETWORK AOC \
, check if the hardware has detected any network interface MAC Add. 

<pr>

<img width="865" height="243" alt="image" src="https://github.com/user-attachments/assets/a0868afd-a21d-469a-971f-5fb5282d7a93" />

<pr>

- (6) Health Eventlog

<pr>

<img width="865" height="557" alt="image" src="https://github.com/user-attachments/assets/3d052a74-8cc7-426d-9a7d-550585153f27" />

<pr>


### 3.3 我方須提供的資料 part 3 - 硬體診斷(DOS)結果 (.pdf)
#### 3.3.1 - 下載 SDO

需先註冊SuperMicro 帳號 & 自備 USB 硬碟 *1 

- SDO download link : https://www.supermicro.com/zh_tw/support/resources/downloadcenter/smsdownload?category=SDO

<pr>

<img width="1637" height="557" alt="image" src="https://github.com/user-attachments/assets/fef30e91-c6c9-455d-b1a9-fb555f4a82e3" />

<pr>

- 下載檔案後,將X86內檔案COPY至USB DISK根目錄下  
<img width="1598" height="542" alt="image" src="https://github.com/user-attachments/assets/2d22d4e2-9758-4447-b304-5b4b3eb56b3d" />

#### 3.3.2 開始 DOS 檢測 (on Server)

- 將 server 完全關機 (非重新啟動)
- 插上有含SDO的USB後,按下開機鍵後啟動server ，並連續點擊`DELETE`進入BIOS ，,看到如下畫面按F11

<pr>
   
<img width="1583" height="852" alt="image" src="https://github.com/user-attachments/assets/6f42f52e-5f93-49fa-be38-bda61b6ee0d4" />

<pr>   

- 選擇UEFI Built-in EFI Shell
<pr>

<img width="1052" height="686" alt="image" src="https://github.com/user-attachments/assets/034f1bcf-1160-4dae-b371-0c22b9206a31" />

<pr>

   
- `ESC` --> `fs0:` (進入USB DISK)

<pr>

<img width="1562" height="467" alt="image" src="https://github.com/user-attachments/assets/2ede1c4e-16f2-4341-9651-8d1bfd68422c" />

<pr>
   
- Enter `SuperDiag.efi /full`

<pr>

<img width="1585" height="566" alt="image" src="https://github.com/user-attachments/assets/3f6e3352-d45e-4e45-95e8-5e3a4f774893" />

<pr>

<img width="1590" height="276" alt="image" src="https://github.com/user-attachments/assets/60909108-c44b-44d5-bd85-d0e46319adc3" />

- 測試完畢後,如下圖
<img width="1601" height="617" alt="image" src="https://github.com/user-attachments/assets/ae2032b0-97dc-4855-a573-c3bd726dadfb" />

- 此工具會在USB磁碟中建立一個資料夾，其中包含電路板名稱、序號和時間
標籤，用於儲存結果。您可以在該資料夾中找到超文本 (.html) 格式的摘要
日誌。 **請提結果`.pdf`檔案**

<img width="1615" height="260" alt="image" src="https://github.com/user-attachments/assets/27f60d41-fd84-4b25-befd-4856f9be7f94" />

**下圖為文件內容**
<img width="1680" height="915" alt="image" src="https://github.com/user-attachments/assets/9fc9e431-c5fd-448d-b777-5b267ccacc80" />
