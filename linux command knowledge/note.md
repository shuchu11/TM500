```
cd installcue/
vim cuedock.yaml
FTP_ADDR = 192.168.8.68 // control PC IP
ETH0_ADDR = 192.168.8.67 // cloudUE ETH0 IP
```
`cd installcue/`
說明：進入名為 installcue 的目錄。

`vim cuedock.yaml`
說明：使用 Vim 編輯器打開或建立名為 cuedock.yaml 的檔案。\
作用：你可以在這個 YAML 格式的設定檔中編輯 cloudUE 或相關服務的設定內容。

`FTP_ADDR = 192.168.8.68 // control PC IP`
說明：這行看起來是設定檔中的參數定義，用來指定 FTP 伺服器的 IP。

`FTP_ADDR`：代表控制電腦（Control PC）的 IP 位址，用於 FTP 通訊。\
註解 `// control PC IP`：說明這個 IP 是控制端的地址。

`ETH0_ADDR = 192.168.8.67 // cloudUE ETH0 IP`
說明：這是 cloudUE 的 eth0 網路介面的 IP 位址設定。

`ETH0_ADDR`：指定 cloudUE 上某個網卡（eth0）的 IP。\
註解 `// cloudUE ETH0 IP`：說明這是 cloudUE 的網路介面用來與外界通訊的 IP。

## Make licience up
```
sudo docker ps   # 列出目前正在執行中的 Docker 容器
sudo docker exec -it  <container id> /bin/bash  # 進入指定容器的交互式 bash 終端機
rm -rf sda1  # 強制刪除名為 sda1 的檔案或資料夾，無法復原！
exit  # 離開容器或 bash 終端機
```
## Bring up gNB
### gNB PTP synchronization
If PTP is already configured as a system service, use the following commands to check its status.
```
sudo journalctl -u ptp4l -f
sudo journalctl -u phc2sys -f
```
🔹 即時查看 ptp4l / phc2sys 服務的日誌輸出

journalctl：用來讀取 systemd 管理的系統日誌

-u ptp4l：指定查看的單位（unit）為 ptp4l，也就是 Precision Time Protocol daemon

-f：持續追蹤日誌輸出（類似 tail -f），會即時顯示新產生的 log

📘 ptp4l 是 PTP（IEEE 1588）用來同步網路時間的服務，常用在 5G/O-RAN、金融或工業場域。
### Set the virtual function to DPDK
建立 VF（虛擬功能）並將其綁定給 DPDK 使用
```
# Create VF and bind VF with DPDK 
cd ~/intel_sw/phy
sudo su # 進入超級使用者模式 (root 身份)
./cvl.sh # 執行 cvl.sh 腳本
exit # 離開 root，回到原本的使用者 shell
```

在 Linux 系統中使用 tuned-adm 工具來切換效能最佳化設定為「實時模式（realtime）」
```
sudo tuned-adm profile realtime
```

### FlexRAN
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/l1/  # 進入 L1 程式的可執行目錄
source ../../../../../../phy/setupenv.sh   # 載入 setupenv.sh 腳本，設定好運行 L1 所需
./l1.sh -xran   # 執行 L1 模組，並傳入參數 `-xran`
```
### testmac
```
sudo su
cd /home/ubuntu/intel_sw/FlexRAN/l1/bin/nr5g/gnb/testmac
source ../../../../../../phy/setupenv.sh 
./l2.sh
```

