#!/usr/bin/env bash
# ============================================================
#              NotRyxenYT • SERVER TOOLKIT
#       Public Raw Installer / Launcher Script
# ============================================================

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
set -u

# ---------------- COLORS ----------------
C=$'\033[36m'
G=$'\033[32m'
R=$'\033[31m'
B=$'\033[34m'
Y=$'\033[33m'
W=$'\033[97m'
P=$'\033[35m'
D=$'\033[90m'
N=$'\033[0m'

pause() {
    echo
    read -r -p "${W}Press Enter to return...${N}" _
}

banner() {
    clear
    echo -e "${P}"
    cat <<'EOF'
╔══════════════════════════════════════════════════════════════╗
║                                                            ║
║                    NotRyxenYT                               ║
║                 SERVER TOOLKIT                              ║
║                                                            ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${N}"
    echo -e "${C} VPS • Pterodactyl • Wings • Cloudflare • Server Tools${N}"
    echo -e "${D}────────────────────────────────────────────────────────────${N}"
    echo
}

# ---------------- DISCORD ----------------
discord_menu() {
    while true; do
        clear
        echo -e "${P}╔══════════════════════════════════════════════════════════════╗${N}"
        echo -e "${P}║${W}                     DISCORD SERVERS                         ${P}║${N}"
        echo -e "${P}╚══════════════════════════════════════════════════════════════╝${N}"
        echo
        echo -e "${C}[1]${N} ${W}PrimeCloud | IT Solutions${N}"
        echo -e "    ${G}https://discord.gg/erYrFrs8RM${N}"
        echo
        echo -e "${C}[2]${N} ${W}NotRyxenYT Offical Discord Server${N}"
        echo -e "    ${G}https://discord.gg/hAkBZkbCF6${N}"
        echo
        echo -e "${R}[0]${N} Back"
        echo
        read -r -p "${Y}Select [0-2]: ${N}" choice

        case "$choice" in
            1)
                echo
                echo "PrimeCloud | IT Solutions"
                echo "https://discord.gg/erYrFrs8RM"
                pause
                ;;
            2)
                echo
                echo "NotRyxenYT Offical Discord Server"
                echo "https://discord.gg/hAkBZkbCF6"
                pause
                ;;
            0)
                return
                ;;
            *)
                echo -e "${R}Invalid option.${N}"
                sleep 1
                ;;
        esac
    done
}

# ---------------- PTERODACTYL ----------------
ptero_menu() {
    while true; do
        clear
        echo -e "${P}╔══════════════════════════════════════════════════════════════╗${N}"
        echo -e "${P}║${W}              PTERODACTYL CONTROL CENTER                     ${P}║${N}"
        echo -e "${P}╚══════════════════════════════════════════════════════════════╝${N}"
        echo
        echo -e "${C}[1]${N} Install Panel"
        echo -e "${C}[2]${N} Create User"
        echo -e "${C}[3]${N} Update Panel"
        echo -e "${C}[4]${N} Install SSL"
        echo -e "${C}[5]${N} Uninstall Panel"
        echo -e "${R}[0]${N} Back"
        echo
        read -r -p "${Y}Select [0-5]: ${N}" opt

        case "$opt" in
            1)
                bash <(curl -fsSL https://raw.githubusercontent.com/nobita329/ptero/main/ptero/panel/pterodactyl/install.sh)
                pause
                ;;
            2)
                if [ -d /var/www/pterodactyl ]; then
                    cd /var/www/pterodactyl || return
                    php artisan p:user:make
                else
                    echo -e "${R}Pterodactyl panel is not installed.${N}"
                fi
                pause
                ;;
            3)
                if [ ! -d /var/www/pterodactyl ]; then
                    echo -e "${R}Pterodactyl panel is not installed.${N}"
                    pause
                    continue
                fi

                cd /var/www/pterodactyl || return
                php artisan down || true
                curl -fLo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
                tar -xzf panel.tar.gz
                COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
                php artisan migrate --seed --force
                php artisan up || true
                rm -f panel.tar.gz
                pause
                ;;
            4)
                bash <(curl -fsSL https://raw.githubusercontent.com/nobita329/ptero/main/ptero/panel/pterodactyl/ssl.sh)
                pause
                ;;
            5)
                if [ -d /var/www/pterodactyl ]; then
                    rm -rf /var/www/pterodactyl
                    echo -e "${G}Panel directory removed.${N}"
                else
                    echo -e "${Y}Panel directory not found.${N}"
                fi
                pause
                ;;
            0)
                return
                ;;
            *)
                echo -e "${R}Invalid option.${N}"
                sleep 1
                ;;
        esac
    done
}

# ---------------- BLUEPRINT ----------------
blueprint_install() {
    clear
    local PT_DIR="/var/www/pterodactyl"

    echo -e "${P}╔══════════════════════════════════════════════════════════════╗${N}"
    echo -e "${P}║${W}              BLUEPRINT AUTO INSTALLER                       ${P}║${N}"
    echo -e "${P}╚══════════════════════════════════════════════════════════════╝${N}"
    echo

    if [ ! -d "$PT_DIR" ]; then
        echo -e "${R}Pterodactyl directory not found: $PT_DIR${N}"
        pause
        return
    fi

    echo -e "${C}[1/6]${N} Installing system dependencies..."
    apt-get update -y
    apt-get install -y curl wget unzip ca-certificates git gnupg zip

    echo -e "${C}[2/6]${N} Installing Node.js 20..."
    mkdir -p /etc/apt/keyrings

    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor --yes -o /etc/apt/keyrings/nodesource.gpg

    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
        > /etc/apt/sources.list.d/nodesource.list

    apt-get update -y
    apt-get install -y nodejs
    npm install -g yarn

    echo -e "${C}[3/6]${N} Downloading Blueprint..."
    cd "$PT_DIR" || return

    local DOWNLOAD_URL
    DOWNLOAD_URL="$(curl -fsSL https://api.github.com/repos/BlueprintFramework/framework/releases/latest \
        | grep '"browser_download_url"' \
        | grep 'release.zip' \
        | cut -d '"' -f 4 \
        | head -n 1)"

    if [ -z "$DOWNLOAD_URL" ]; then
        echo -e "${R}Blueprint release could not be found.${N}"
        pause
        return
    fi

    curl -fL "$DOWNLOAD_URL" -o release.zip
    unzip -o release.zip
    rm -f release.zip

    echo -e "${C}[4/6]${N} Configuring Blueprint..."
    cat > "$PT_DIR/.blueprintrc" <<'EOF'
WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";
EOF

    [ -f "$PT_DIR/blueprint.sh" ] && chmod +x "$PT_DIR/blueprint.sh"

    echo -e "${C}[5/6]${N} Running Blueprint installer..."
    if [ -f "$PT_DIR/blueprint.sh" ]; then
        bash "$PT_DIR/blueprint.sh"
    else
        echo -e "${R}blueprint.sh was not found after extraction.${N}"
        pause
        return
    fi

    echo -e "${C}[6/6]${N} Fixing permissions and clearing cache..."
    chown -R www-data:www-data "$PT_DIR"
    find "$PT_DIR" -type d -exec chmod 755 {} \;
    find "$PT_DIR" -type f -exec chmod 644 {} \;
    chmod +x "$PT_DIR/artisan" "$PT_DIR/blueprint.sh" 2>/dev/null || true

    cd "$PT_DIR" || return
    yarn install --production --silent || true
    php artisan view:clear || true
    php artisan config:clear || true
    php artisan route:clear || true

    echo
    echo -e "${G}Blueprint installation completed.${N}"
    pause
}

# ---------------- CLOUDFLARE ----------------
cloudflare_menu() {
    while true; do
        clear

        local status="NOT INSTALLED"
        if command -v cloudflared >/dev/null 2>&1; then
            if command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet cloudflared; then
                status="ACTIVE"
            else
                status="INSTALLED / STOPPED"
            fi
        fi

        echo -e "${P}╔══════════════════════════════════════════════════════════════╗${N}"
        echo -e "${P}║${W}                 CLOUDFLARE MANAGER                          ${P}║${N}"
        echo -e "${P}║${W}                     NotRyxenYT                              ${P}║${N}"
        echo -e "${P}╚══════════════════════════════════════════════════════════════╝${N}"
        echo
        echo -e "${C}Status:${N} ${W}$status${N}"
        echo
        echo -e "${G}[1]${N} Install / Update Cloudflared"
        echo -e "${R}[2]${N} Uninstall Cloudflared"
        echo -e "${R}[0]${N} Back"
        echo
        read -r -p "${Y}Select [0-2]: ${N}" choice

        case "$choice" in
            1)
                clear
                echo -e "${C}Installing Cloudflared...${N}"
                echo

                mkdir -p /usr/share/keyrings

                curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg \
                    | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

                echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' \
                    > /etc/apt/sources.list.d/cloudflared.list

                apt-get update -y
                apt-get install -y cloudflared

                if ! command -v cloudflared >/dev/null 2>&1; then
                    echo -e "${R}Cloudflared installation failed.${N}"
                    pause
                    continue
                fi

                echo
                echo -e "${Y}Paste your Cloudflare Tunnel token.${N}"
                echo -e "${D}You can paste the full 'cloudflared service install ...' command.${N}"
                echo

                read -r -p "${C}Token: ${N}" USER_TOKEN

                CLEAN_TOKEN="$(printf '%s' "$USER_TOKEN" \
                    | sed 's#sudo cloudflared service install ##' \
                    | sed 's#cloudflared service install ##' \
                    | xargs)"

                if [ -z "$CLEAN_TOKEN" ]; then
                    echo -e "${R}Token cannot be empty.${N}"
                    pause
                    continue
                fi

                cloudflared service uninstall >/dev/null 2>&1 || true
                cloudflared service install "$CLEAN_TOKEN"

                sleep 2

                if command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet cloudflared; then
                    echo -e "${G}Cloudflare Tunnel is online.${N}"
                else
                    echo -e "${Y}Service was installed, but is not currently active.${N}"
                    echo -e "${D}Check: journalctl -u cloudflared -n 50${N}"
                fi

                pause
                ;;

            2)
                echo
                read -r -p "${Y}Remove Cloudflared completely? (y/N): ${N}" confirm

                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    if command -v cloudflared >/dev/null 2>&1; then
                        cloudflared service uninstall >/dev/null 2>&1 || true
                    fi

                    apt-get remove -y cloudflared || true
                    rm -f /etc/apt/sources.list.d/cloudflared.list
                    rm -f /usr/share/keyrings/cloudflare-main.gpg

                    echo -e "${G}Cloudflared removed.${N}"
                else
                    echo -e "${D}Cancelled.${N}"
                fi

                pause
                ;;

            0)
                return
                ;;

            *)
                echo -e "${R}Invalid option.${N}"
                sleep 1
                ;;
        esac
    done
}

# ---------------- MAIN MENU ----------------
main_menu() {
    while true; do
        banner

        echo -e "${C}[1]${N} Discord Servers"
        echo -e "${C}[2]${N} Proxmox VE (Docker) Install"
        echo -e "${C}[3]${N} VM/KVM Installer"
        echo -e "${C}[4]${N} Pterodactyl Panel Installer"
        echo -e "${C}[5]${N} Wings Installer"
        echo -e "${C}[6]${N} Blueprint + Addon Installer"
        echo -e "${C}[7]${N} Cloudflare Tunnel Manager"
        echo -e "${C}[8]${N} Main Tools"
        echo -e "${R}[0]${N} Exit"
        echo
        echo -e "${D}────────────────────────────────────────────────────────────${N}"
        echo
        read -r -p "${Y}NotRyxenYT@server:~# ${N}" choice

        case "$choice" in
            1)
                discord_menu
                ;;
            2)
                if ! command -v docker >/dev/null 2>&1; then
                    echo -e "${R}Docker is not installed on this VPS.${N}"
                else
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
                fi
                pause
                ;;
            3)
                bash <(curl -fsSL https://raw.githubusercontent.com/vpscreate123-web/mainnemu/main/Mainmenu)
                pause
                ;;
            4)
                ptero_menu
                ;;
            5)
                bash <(curl -fsSL https://raw.githubusercontent.com/nobita329/ptero/main/ptero/wings/install.sh)
                pause
                ;;
            6)
                blueprint_install
                ;;
            7)
                cloudflare_menu
                ;;
            8)
                bash <(curl -fsSL https://raw.githubusercontent.com/vpscreate123-web/4-tools/main/mainmenu)
                pause
                ;;
            0)
                clear
                echo -e "${P}NotRyxenYT Server Toolkit${N}"
                echo -e "${G}Goodbye!${N}"
                exit 0
                ;;
            *)
                echo -e "${R}Invalid option.${N}"
                sleep 1
                ;;
        esac
    done
}

# ---------------- START ----------------
main_menu
