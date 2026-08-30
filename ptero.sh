#!/usr/bin/env bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

set -u

# ==========================================================
#                 NOTRYXENYT CONTROL CENTER
#                 Premium Server Management
# ==========================================================

# ---- COLORS ----
C=$'\033[36m'
G=$'\033[32m'
R=$'\033[31m'
B=$'\033[34m'
Y=$'\033[33m'
W=$'\033[97m'
P=$'\033[35m'
BLINK=$'\033[5m'
N=$'\033[0m'

# ==========================================================
# TYPEWRITER
# ==========================================================

typewriter() {
    local text="$1"
    local delay=0.003

    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep "$delay"
    done

    printf "\n"
}

# ==========================================================
# PROGRESS BAR
# ==========================================================

progress_bar() {
    echo
    echo -e "${C}Initializing NotRyxenYT System...${N}"

    for i in {1..35}; do
        printf "${G}#${N}"
        sleep 0.025
    done

    echo
    echo

    for i in {0..100..10}; do
        printf "\r${Y}Loading System: ${i}%%%${N}"
        sleep 0.10
    done

    echo
    sleep 0.7
}

# ==========================================================
# NOTRYXENYT ASCII LOGO
# ==========================================================

logo() {
    echo -e "${P}"
    echo "███╗   ██╗ ██████╗ ████████╗██████╗ ██╗   ██╗██╗  ██╗███████╗███╗   ██╗"
    echo "████╗  ██║██╔═══██╗╚══██╔══╝██╔══██╗╚██╗ ██╔╝██║ ██╔╝██╔════╝████╗  ██║"
    echo "██╔██╗ ██║██║   ██║   ██║   ██████╔╝ ╚████╔╝ █████╔╝ █████╗  ██╔██╗ ██║"
    echo "██║╚██╗██║██║   ██║   ██║   ██╔══██╗  ╚██╔╝  ██╔═██╗ ██╔══╝  ██║╚██╗██║"
    echo "██║ ╚████║╚██████╔╝   ██║   ██║  ██║   ██║   ██║  ██╗███████╗██║ ╚████║"
    echo "╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝"
    echo -e "${N}"
}

# ==========================================================
# INTRO
# ==========================================================

intro() {
    clear

    logo

    echo
    typewriter "⚡ NOTRYXENYT SERVER CONTROL CENTER"
    typewriter "🚀 Premium VPS & Server Management System"
    echo

    progress_bar

    clear
}

# ==========================================================
# HEADER
# ==========================================================

display_header() {
    clear

    echo -e "${P}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                  NOTRYXENYT CONTROL CENTER                  ║"
    echo "║              PREMIUM SERVER MANAGEMENT TOOL                 ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${N}"

    echo
}

header() {
    echo -e "${P}${BLINK}⚡ NOTRYXENYT CONTROL CENTER ⚡${N}"
    echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    echo -e "${C}        VPS • PANEL • CLOUD • SERVER MANAGEMENT${N}"
    echo
}

pause() {
    echo
    read -r -p "${W}Press [Enter] to return...${N}" dummy
}

# ==========================================================
# PTERODACTYL MENU
# ==========================================================

ptero_menu() {

    while true; do

        clear

        echo -e "${P}"
        echo "╔════════════════════════════════════════════════════════════╗"
        echo "║             NOTRYXENYT PTERODACTYL MANAGER                ║"
        echo "║                    PANEL CONTROL CENTER                   ║"
        echo "╚════════════════════════════════════════════════════════════╝"
        echo -e "${N}"

        echo
        echo -e "${C} 1)${W} Install Pterodactyl Panel${N}"
        echo -e "${C} 2)${W} Create Panel User${N}"
        echo -e "${C} 3)${W} Update Panel${N}"
        echo -e "${C} 4)${W} Install SSL${N}"
        echo -e "${R} 5)${W} Uninstall Panel${N}"
        echo -e "${Y} 6)${W} Back to Main Menu${N}"

        echo
        read -r -p "${P}NotRyxenYT@Pterodactyl:~# ${N}" opt

        case "$opt" in

            1)
                echo
                echo -e "${C}Starting Pterodactyl Panel installation...${N}"
                bash <(curl -fsSL \
                https://raw.githubusercontent.com/nobita329/ptero/main/ptero/panel/pterodactyl/install.sh)

                pause
                ;;

            2)
                if [ -d "/var/www/pterodactyl" ]; then
                    cd /var/www/pterodactyl || exit
                    php artisan p:user:make
                else
                    echo -e "${R}Pterodactyl Panel is not installed.${N}"
                fi

                pause
                ;;

            3)
                if [ ! -d "/var/www/pterodactyl" ]; then
                    echo -e "${R}Pterodactyl Panel is not installed!${N}"
                    pause
                    continue
                fi

                cd /var/www/pterodactyl || exit

                echo -e "${C}Putting panel into maintenance mode...${N}"
                php artisan down

                echo -e "${C}Downloading latest panel...${N}"
                curl -Lo panel.tar.gz \
                https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz

                tar -xzvf panel.tar.gz

                echo -e "${C}Installing Composer dependencies...${N}"
                COMPOSER_ALLOW_SUPERUSER=1 \
                composer install --no-dev --optimize-autoloader

                echo -e "${C}Running migrations...${N}"
                php artisan migrate --seed --force

                php artisan up

                rm -f panel.tar.gz

                echo -e "${G}Panel update completed.${N}"

                pause
                ;;

            4)
                echo
                echo -e "${C}Starting SSL installer...${N}"

                bash <(curl -fsSL \
                https://raw.githubusercontent.com/nobita329/ptero/main/ptero/panel/pterodactyl/ssl.sh)

                pause
                ;;

            5)
                echo
                echo -e "${R}WARNING: This removes the Pterodactyl panel files.${N}"
                read -r -p "Continue? (y/N): " confirm

                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    rm -rf /var/www/pterodactyl
                    echo -e "${G}Panel removed.${N}"
                else
                    echo -e "${Y}Operation cancelled.${N}"
                fi

                sleep 2
                ;;

            6)
                break
                ;;

            *)
                echo -e "${R}Invalid option.${N}"
                sleep 1
                ;;

        esac

    done
}

# ==========================================================
# BLUEPRINT INSTALLER
# ==========================================================

blueprint_installer() {

    PT_DIR="/var/www/pterodactyl"

    clear

    echo -e "${P}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║              NOTRYXENYT BLUEPRINT INSTALLER               ║"
    echo "║                    AUTO SETUP & FIX                       ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${N}"

    if [ "$EUID" -ne 0 ]; then
        echo -e "${R}Please run this tool as root.${N}"
        pause
        return
    fi

    echo
    echo -e "${Y}Target:${N} ${C}$PT_DIR${N}"
    echo

    if [ ! -d "$PT_DIR" ]; then
        echo -e "${R}Pterodactyl directory was not found.${N}"
        pause
        return
    fi

    echo -e "${C}[1/7] Checking Pterodactyl...${N}"
    echo -e "${G}✔ Pterodactyl detected.${N}"

    echo -e "${C}[2/7] Installing dependencies...${N}"

    apt update -y -q
    apt install -y curl wget unzip ca-certificates git gnupg zip -q

    echo -e "${G}✔ Dependencies ready.${N}"

    echo -e "${C}[3/7] Setting up Node.js 20...${N}"

    mkdir -p /etc/apt/keyrings

    curl -fsSL \
    https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
    > /etc/apt/sources.list.d/nodesource.list

    apt update -y -q
    apt install -y nodejs -q

    npm i -g yarn

    echo -e "${G}✔ Node.js environment ready.${N}"

    echo -e "${C}[4/7] Downloading Blueprint...${N}"

    cd "$PT_DIR" || return

    DOWNLOAD_URL=$(curl -s \
    https://api.github.com/repos/BlueprintFramework/framework/releases/latest \
    | grep 'browser_download_url' \
    | grep 'release.zip' \
    | cut -d '"' -f 4)

    if [ -z "$DOWNLOAD_URL" ]; then
        echo -e "${R}Unable to find Blueprint release.${N}"
        pause
        return
    fi

    wget -q "$DOWNLOAD_URL" -O "$PT_DIR/release.zip"

    unzip -o -q release.zip

    echo -e "${G}✔ Blueprint files extracted.${N}"

    echo -e "${C}[5/7] Configuring Blueprint...${N}"

    cat > "$PT_DIR/.blueprintrc" <<EOF
WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";
EOF

    chmod +x "$PT_DIR/blueprint.sh"

    echo -e "${G}✔ Configuration applied.${N}"

    echo -e "${C}[6/7] Running Blueprint installer...${N}"

    bash "$PT_DIR/blueprint.sh"

    echo -e "${C}[7/7] Running NotRyxenYT auto-fix...${N}"

    echo -e "${Y}➜ Fixing permissions...${N}"

    chown -R www-data:www-data "$PT_DIR"

    find "$PT_DIR" -type d -exec chmod 755 {} \;
    find "$PT_DIR" -type f -exec chmod 644 {} \;

    chmod +x "$PT_DIR/artisan" "$PT_DIR/blueprint.sh" 2>/dev/null

    echo -e "${Y}➜ Installing frontend dependencies...${N}"

    cd "$PT_DIR" || return

    yarn install --production --silent

    echo -e "${Y}➜ Clearing panel cache...${N}"

    php artisan view:clear
    php artisan config:clear
    php artisan route:clear

    echo
    echo -e "${G}════════════════════════════════════════════════════════════${N}"
    echo -e "${G}       NOTRYXENYT BLUEPRINT SETUP COMPLETED                 ${N}"
    echo -e "${G}════════════════════════════════════════════════════════════${N}"

    pause
}

# ==========================================================
# CLOUDFLARE INSTALLER
# ==========================================================

cloudflare_manager() {

    install_cf() {

        clear

        echo -e "${P}"
        echo "╔════════════════════════════════════════════════════════════╗"
        echo "║              NOTRYXENYT CLOUDFLARE MANAGER               ║"
        echo "║                   TUNNEL CONTROL CENTER                   ║"
        echo "╚════════════════════════════════════════════════════════════╝"
        echo -e "${N}"

        echo
        echo -e "${C}Starting Cloudflare installation...${N}"
        echo

        echo -e "${Y}[1/4] Configuring repository...${N}"

        mkdir -p --mode=0755 /usr/share/keyrings

        curl -fsSL \
        https://pkg.cloudflare.com/cloudflare-main.gpg \
        | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

        echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' \
        | tee /etc/apt/sources.list.d/cloudflared.list >/dev/null

        echo -e "${G}✔ Repository configured.${N}"

        echo -e "${Y}[2/4] Installing Cloudflared...${N}"

        apt-get update -qq
        apt-get install -y cloudflared -qq

        if command -v cloudflared >/dev/null 2>&1; then
            echo -e "${G}✔ Cloudflared installed.${N}"
        else
            echo -e "${R}✖ Cloudflared installation failed.${N}"
            pause
            return
        fi

        echo -e "${Y}[3/4] Cleaning old service...${N}"

        if command -v systemctl >/dev/null 2>&1; then
            cloudflared service uninstall >/dev/null 2>&1 || true
        fi

        echo -e "${G}✔ Old service cleaned.${N}"

        echo
        echo -e "${Y}╔══════════════════════════════════════════════════════════╗${N}"
        echo -e "${Y}║                    TUNNEL TOKEN                         ║${N}"
        echo -e "${Y}╚══════════════════════════════════════════════════════════╝${N}"
        echo
        echo -e "${W}Paste your Cloudflare Tunnel token below.${N}"
        echo

        read -r -p "${P}NotRyxenYT@Cloudflare:~# ${N}" USER_TOKEN

        CLEAN_TOKEN=$(echo "$USER_TOKEN" \
        | sed 's/sudo cloudflared service install //g' \
        | sed 's/cloudflared service install //g' \
        | xargs)

        if [ -z "$CLEAN_TOKEN" ]; then
            echo -e "${R}Token cannot be empty.${N}"
            pause
            return
        fi

        echo
        echo -e "${Y}[4/4] Registering Cloudflare Tunnel...${N}"

        cloudflared service install "$CLEAN_TOKEN"

        echo
        echo -e "${C}Starting tunnel...${N}"

        sleep 2

        if systemctl is-active --quiet cloudflared; then
            echo
            echo -e "${G}✔ Cloudflare Tunnel is ONLINE.${N}"
        else
            echo
            echo -e "${R}✖ Cloudflare service failed to start.${N}"
            echo -e "${Y}Check:${N} journalctl -u cloudflared -f"
        fi

        pause
    }

    uninstall_cf() {

        clear

        echo -e "${R}"
        echo "╔════════════════════════════════════════════════════════════╗"
        echo "║               NOTRYXENYT CLOUDFLARE REMOVE               ║"
        echo "╚════════════════════════════════════════════════════════════╝"
        echo -e "${N}"

        echo
        echo -e "${Y}This will remove Cloudflared from this server.${N}"
        echo

        read -r -p "Continue? (y/N): " confirm

        if [[ "$confirm" =~ ^[Yy]$ ]]; then

            cloudflared service uninstall >/dev/null 2>&1 || true

            apt-get remove -y cloudflared -qq >/dev/null 2>&1 || true

            rm -f /etc/apt/sources.list.d/cloudflared.list
            rm -f /usr/share/keyrings/cloudflare-main.gpg

            echo
            echo -e "${G}✔ Cloudflared completely removed.${N}"

        else

            echo -e "${Y}Operation cancelled.${N}"

        fi

        sleep 2
    }

    while true; do

        clear

        echo -e "${P}"
        echo "╔════════════════════════════════════════════════════════════╗"
        echo "║              NOTRYXENYT CLOUDFLARE MANAGER               ║"
        echo "╚════════════════════════════════════════════════════════════╝"
        echo -e "${N}"

        if command -v cloudflared >/dev/null 2>&1; then
            echo -e "${G}● Cloudflared: INSTALLED${N}"
        else
            echo -e "${R}● Cloudflared: NOT INSTALLED${N}"
        fi

        echo
        echo -e "${G}[1]${W} Install / Update Cloudflare Tunnel${N}"
        echo -e "${R}[2]${W} Uninstall Cloudflare Completely${N}"
        echo -e "${Y}[0]${W} Back to Main Menu${N}"

        echo
        read -r -p "${P}NotRyxenYT@Cloudflare:~# ${N}" choice

        case "$choice" in
            1) install_cf ;;
            2) uninstall_cf ;;
            0) break ;;
            *) echo -e "${R}Invalid option.${N}"; sleep 1 ;;
        esac

    done
}

# ==========================================================
# MAIN MENU
# ==========================================================

intro

while true; do

    clear
    header

    echo -e "${C}  1)${W} 💬 Discord Community${N}"
    echo -e "${C}  2)${W} 🐋 Proxmox VE Docker Setup${N}"
    echo -e "${C}  3)${W} 🕹️ VM / KVM Installer${N}"
    echo -e "${C}  4)${W} 🖥️ Pterodactyl Panel Manager${N}"
    echo -e "${C}  5)${W} 🪽 Wings Installer${N}"
    echo -e "${C}  6)${W} 🎨 Blueprint Installer${N}"
    echo -e "${C}  7)${W} ☁️ Cloudflare Tunnel Manager${N}"
    echo -e "${C}  8)${W} 🛠️ Server Tools${N}"
    echo -e "${R}  0)${W} 🛑 Exit${N}"

    echo
    echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    echo

    read -r -p "${P}NotRyxenYT@Server:~# ${N}" choice

    case "$choice" in

        1)
            clear

            echo
            echo -e "${P}╔══════════════════════════════════════════════════════════╗${N}"
            echo -e "${P}║                 NOTRYXENYT COMMUNITY                    ║${N}"
            echo -e "${P}╚══════════════════════════════════════════════════════════╝${N}"
            echo
            echo -e "${C}Discord:${N}"
            echo -e "${G}https://discord.gg/2rYEHharqA${N}"

            pause
            ;;

        2)
            clear

            echo -e "${C}Starting NotRyxenYT Proxmox environment...${N}"
            echo

            docker run -itd \
              --name proxmoxve \
              --hostname pve \
              --privileged \
              --cgroupns=host \
              --security-opt apparmor=unconfined \
              --security-opt seccomp=unconfined \
              -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
              -v /lib/modules:/lib/modules:ro \
              -v /dev/fuse:/dev/fuse \
              -v /sys/kernel/debug:/sys/kernel/debug \
              -p 8006:8006 \
              --restart unless-stopped \
              rtedpro/proxmox:9.0.11

            pause
            ;;

        3)
            clear

            echo -e "${C}Starting VM/KVM installer...${N}"
            echo

            bash <(curl -fsSL \
            https://raw.githubusercontent.com/vpscreate123-web/mainnemu/main/Mainmenu)

            pause
            ;;

        4)
            ptero_menu
            ;;

        5)
            clear

            echo -e "${C}Starting NotRyxenYT Wings installer...${N}"
            echo

            bash <(curl -fsSL \
            https://raw.githubusercontent.com/nobita329/ptero/main/ptero/wings/install.sh)

            pause
            ;;

        6)
            blueprint_installer
            ;;

        7)
            cloudflare_manager
            ;;

        8)
            clear

            echo -e "${C}Starting NotRyxenYT Server Tools...${N}"
            echo

            bash <(curl -fsSL \
            https://raw.githubusercontent.com/vpscreate123-web/4-tools/main/mainmenu)

            pause
            ;;

        0)
            clear

            echo
            echo -e "${P}════════════════════════════════════════════════════════════${N}"
            echo -e "${G}          NOTRYXENYT SERVER CONTROL CENTER                 ${N}"
            echo -e "${W}                 Session closed.                           ${N}"
            echo -e "${P}════════════════════════════════════════════════════════════${N}"
            echo

            sleep 1
            exit 0
            ;;

        *)
            echo
            echo -e "${R}✖ Invalid Option!${N}"
            sleep 1
            ;;

    esac

done
