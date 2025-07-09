```
cd installcue/
vim cuedock.yaml
FTP_ADDR = 192.168.8.68 // control PC IP
ETH0_ADDR = 192.168.8.67 // cloudUE ETH0 IP
```
`cd installcue/`
說明：進入名為 installcue 的目錄。/
作用：切換目前的工作目錄到 installcue，你接下來的操作（如編輯檔案）都會以此目錄為基準。

`vim cuedock.yaml`
說明：使用 Vim 編輯器打開或建立名為 cuedock.yaml 的檔案。/
作用：你可以在這個 YAML 格式的設定檔中編輯 cloudUE 或相關服務的設定內容。

`FTP_ADDR = 192.168.8.68 // control PC IP`
說明：這行看起來是設定檔中的參數定義，用來指定 FTP 伺服器的 IP。

`FTP_ADDR`：代表控制電腦（Control PC）的 IP 位址，用於 FTP 通訊。

註解 `// control PC IP`：說明這個 IP 是控制端的地址。

`ETH0_ADDR = 192.168.8.67 // cloudUE ETH0 IP`
說明：這是 cloudUE 的 eth0 網路介面的 IP 位址設定。

`ETH0_ADDR`：指定 cloudUE 上某個網卡（eth0）的 IP。

註解 `// cloudUE ETH0 IP`：說明這是 cloudUE 的網路介面用來與外界通訊的 IP。

