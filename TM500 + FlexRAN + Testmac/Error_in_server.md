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

## 1.2 🛠 嘗試處理步驟
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

### 2.1 ❗ 關鍵錯誤與警告訊息解析

### 2.2 🔴 嚴重錯誤 (`journalctl -p err`)
- `SGX disabled by BIOS`  
  → 非致命，可略過，除非使用 SGX 技術。
- `netopeer2-server`: 模組 `writable-running` 未啟用  
  → 需要重新設定 sysrepo。
- `Failed to start Sysrepo PluginD Daemon`  
  → 主因之一，服務啟動失敗且重啟過快。
- `gnome-session/gnome-shell`: 大量 `GLib-GIO-CRITICAL`、`JS ERROR`、MESA 驅動錯誤  
  → 導致 GUI 與「設定」等視窗無法顯示。

---

### 2.3 🟡 警告訊息 (`journalctl -p warning`)
- `crashkernel`, `SPD`, `ACPI`, `ata` 等硬體初始化警告
- `listenfd`、`device_register()` 等過時 API 警告
- Snap 掛載失敗：  
  `auto-import --mount=/dev/sda` → `exit code 1`
- MESA 找不到 `ast_dri.so`  
  → 缺少 AST 顯示驅動（多見於 BMC 環境）

---

### 2.4 🟢 D-Bus 狀態 (`systemctl status dbus.service`)
- 狀態：`active (running)` ✅  
- 但 `GeoClue`, `BlueZ`, `timedate1` 等初始化服務超時或失敗。

---

## 2.5 🛠 嘗試處理步驟 (需要先解決server無法連接網路的問題)

### 修復 GNOME 套件
```bash
# 更新套件清單，確保抓到最新版的套件資訊（不會升級 Ubuntu 版本）
sudo apt update

# 重新安裝 Ubuntu 桌面環境相關套件（ubuntu-desktop, gnome-shell, gnome-session）
# 常用於修復桌面損壞、無法登入等問題
sudo apt install --reinstall ubuntu-desktop gnome-shell gnome-session

# 嘗試修復任何已破損或依賴缺失的套件安裝問題
sudo apt install --fix-broken
```
