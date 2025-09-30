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

<img src="https://github.com/user-attachments/assets/949cea9e-5091-43ab-a1a7-47293b431445" width="30%"></img>
<img src="https://github.com/user-attachments/assets/49ced659-eb08-4c5d-a340-03e83b575c8f" width="30%"></img>
<img src="https://github.com/user-attachments/assets/6913d7b7-7293-4d2b-9d52-f64ac7a7b93d" width="30%"></img> 

---

## 🚀 Installation

```bash
git clone https://github.com/dennishilk/SPDIF-Fix-Tool.git
cd spdif-fix
chmod +x spdif-fix.sh
./spdif-fix.sh

1 - fix
2 - undo
3 - close


No Warranty Disclaimer

The software in this repository is provided "as is", without warranty of any kind.
I make no guarantees regarding the functionality, correctness, or suitability of this code for any purpose.
Use it at your own risk. I am not responsible for any damages, data loss, or issues that may arise from using this software.
