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

---

## 🚀 Installation

```bash
git clone https://github.com/dennishilk/SPDIF-Fix-Tool.git
cd <repo-name>
chmod +x spdif-fix.sh
./spdif-fix.sh
