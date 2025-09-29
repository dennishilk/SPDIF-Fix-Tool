# SPDIF Fix Tool 🎵

A simple interactive Bash tool to **fix SPDIF sound delay & standby issues on Linux**.  
Supports **PulseAudio**, **PipeWire**, and **ALSA**.  

---

## ✨ Features

- Keeps SPDIF output active → no more sound delay  
- Prevents SPDIF from going into standby  
- Works with:
  - PulseAudio (removes `module-suspend-on-idle`)
  - PipeWire (disables suspend in `pipewire.conf`)
  - ALSA (creates `.asoundrc` for SPDIF keepalive)
- Interactive menu with progress indicators  
- Automatically restarts PulseAudio / PipeWire  
- Backup & restore of original configuration

-   <a href="https://www.buymeacoffee.com/dennishilk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

---

## 🚀 Installation

```bash
git clone https://github.com/dennishilk/SPDIF-Fix-Tool.git
cd SPDIF-Fix-Tool
chmod +x spdif-fix.sh
./spdif-fix.sh

1 - fix
2 - undo
3 - close

![Image](https://github.com/user-attachments/assets/0fc17b57-e71d-46c3-ab5d-29545a13e767)
![fix](https://github.com/user-attachments/assets/5a13e96f-c15c-4c36-852a-5a5a7ab5dd50)
![unfix](https://github.com/user-attachments/assets/35c3506d-261e-482b-9173-f99000ad5a40)



