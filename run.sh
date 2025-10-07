#############################
#  Spdif-fix by Dennis Hilk #
#############################

#!/usr/bin/env bash
# SPDIF Sound Delay Fix Tool mit interaktivem Menü und Fortschrittsanzeige
# Einfach starten: ./spdif-fix.sh

set -e

echo "SPDIF Sound Delay Fix Tool"
echo "By Dennis Hilk"

# Fortschrittsanzeige Funktion
show_step() {
    echo ""
    echo "➡️  $1"
}

show_done() {
    echo "✅ Fertig!"
}

restart_soundserver() {
    show_step "Soundserver neu starten..."
    # PulseAudio neustarten
    if pgrep -x "pulseaudio" > /dev/null; then
        echo "   🔄 PulseAudio..."
        pulseaudio -k
        pulseaudio --start
    fi
    # PipeWire neustarten
    if pgrep -x "pipewire" > /dev/null; then
        echo "   🔄 PipeWire..."
        systemctl --user restart pipewire pipewire-pulse || true
    fi
    show_done
}

# Menü anzeigen
echo ""
echo "Bitte wähle eine Option:"
echo "1) Fix anwenden"
echo "2) Fix zurücksetzen"
echo "3) Beenden"
read -rp "Auswahl (1/2/3): " CHOICE

if [ "$CHOICE" = "1" ]; then
    echo ""
    echo "🔧 Fix anwenden..."
    
    # PulseAudio
    if pgrep -x "pulseaudio" > /dev/null; then
        show_step "PulseAudio erkannt, Standby-Modul entladen..."
        pactl unload-module module-suspend-on-idle 2>/dev/null || true
        if [ -f /etc/pulse/default.pa ]; then
            sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
            sudo sed -i '/module-suspend-on-idle/s/^/#/' /etc/pulse/default.pa
            show_done
        fi
    fi

    # PipeWire
    if pgrep -x "pipewire" > /dev/null; then
        show_step "PipeWire erkannt, Suspend deaktivieren..."
        CONFIG_DIR="$HOME/.config/pipewire"
        CONFIG_FILE="$CONFIG_DIR/pipewire.conf"
        mkdir -p "$CONFIG_DIR"
        [ ! -f "$CONFIG_FILE" ] && cp /usr/share/pipewire/pipewire.conf "$CONFIG_FILE" 2>/dev/null || true
        if [ -f "$CONFIG_FILE" ]; then
            cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
            sed -i '/suspend-on-idle/s/^/#/' "$CONFIG_FILE"
            show_done
        fi
    fi

    # ALSA
    ALSA_FILE="$HOME/.asoundrc"
    if [ ! -f "$ALSA_FILE" ]; then
        show_step "ALSA Keepalive anlegen..."
        cat << 'EOF' > "$ALSA_FILE"
pcm.spdif_keepalive {
    type plug
    slave.pcm "spdif"
}
EOF
        show_done
    fi

    restart_soundserver
    echo ""
    echo "🎉 Fix angewendet! Alles bereit."

elif [ "$CHOICE" = "2" ]; then
    echo ""
    echo "🔧 Fix zurücksetzen..."
    
    # PulseAudio
    if pgrep -x "pulseaudio" > /dev/null; then
        show_step "PulseAudio erkannt, Standby-Modul wiederherstellen..."
        if [ -f /etc/pulse/default.pa.bak ]; then
            sudo mv /etc/pulse/default.pa.bak /etc/pulse/default.pa
        else
            sudo sed -i 's/^#\(.*module-suspend-on-idle.*\)/\1/' /etc/pulse/default.pa 2>/dev/null || true
            pactl load-module module-suspend-on-idle 2>/dev/null || true
        fi
        show_done
    fi

    # PipeWire
    if pgrep -x "pipewire" > /dev/null; then
        show_step "PipeWire erkannt, Suspend wieder aktivieren..."
        CONFIG_FILE="$HOME/.config/pipewire/pipewire.conf"
        if [ -f "$CONFIG_FILE.bak" ]; then
            mv "$CONFIG_FILE.bak" "$CONFIG_FILE"
        else
            sed -i 's/^#\(.*suspend-on-idle.*\)/\1/' "$CONFIG_FILE" 2>/dev/null || true
        fi
        show_done
    fi

    # ALSA
    ALSA_FILE="$HOME/.asoundrc"
    if [ -f "$ALSA_FILE" ]; then
        show_step "ALSA Keepalive entfernen..."
        rm "$ALSA_FILE"
        show_done
    fi

    restart_soundserver
    echo ""
    echo "🎉 Reset abgeschlossen! Alles wiederhergestellt."

elif [ "$CHOICE" = "3" ]; then
    echo "Abbruch. Kein Fix angewendet."
    exit 0
else
    echo "❌ Ungültige Auswahl. Bitte 1, 2 oder 3 eingeben."
    exit 1
fi
