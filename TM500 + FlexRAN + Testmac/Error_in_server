# Ubuntu Server 啟動錯誤診斷筆記（maxwell）

> 日期：2025-07-22  
> Server IP：192.168.8.76  
> 使用者：ubuntu@maxwell  
> 目的：診斷無法進入 GUI，且看不到「Settings」圖示的錯誤情形

---

## 📸 錯誤與警告截圖

1. `journalctl -b -p err`  
   ![錯誤訊息1](./4fa46658-c2c1-4ef1-b1e3-3a6348cc9543.png)

2. `journalctl -b -p warning`  
   ![錯誤訊息2](./d77569a2-4c9f-4de3-a72b-05494a30089c.png)

3. `systemctl status dbus.service`  
   ![錯誤訊息3](./240c0e8b-8484-4b80-9ca9-168a300032df.png)

---

## ❗ 關鍵錯誤與警告訊息解析

### 🔴 嚴重錯誤 (`journalctl -p err`)
- `SGX disabled by BIOS`  
  → 非致命，可略過，除非使用 SGX 技術。
- `netopeer2-server`: 模組 `writable-running` 未啟用  
  → 需要重新設定 sysrepo。
- `Failed to start Sysrepo PluginD Daemon`  
  → 主因之一，服務啟動失敗且重啟過快。
- `gnome-session/gnome-shell`: 大量 `GLib-GIO-CRITICAL`、`JS ERROR`、MESA 驅動錯誤  
  → 導致 GUI 與「設定」等視窗無法顯示。

---

### 🟡 警告訊息 (`journalctl -p warning`)
- `crashkernel`, `SPD`, `ACPI`, `ata` 等硬體初始化警告
- `listenfd`、`device_register()` 等過時 API 警告
- Snap 掛載失敗：  
  `auto-import --mount=/dev/sda` → `exit code 1`
- MESA 找不到 `ast_dri.so`  
  → 缺少 AST 顯示驅動（多見於 BMC 環境）

---

### 🟢 D-Bus 狀態 (`systemctl status dbus.service`)
- 狀態：`active (running)` ✅  
- 但 `GeoClue`, `BlueZ`, `timedate1` 等初始化服務超時或失敗。

---

## 🛠 建議處理步驟

### 1️⃣ 修復 GNOME 套件
```bash
sudo apt update
sudo apt install --reinstall ubuntu-desktop gnome-shell gnome-session
sudo apt install --fix-broken
