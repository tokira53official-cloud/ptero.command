#!/usr/bin/env bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

set -u

# ============================================================
#                 NotRyxenYT • SERVER TOOLKIT
# ============================================================

# ---- COLORS ----
C=$'\033[36m'
G=$'\033[32m'
R=$'\033[31m'
B=$'\033[34m'
Y=$'\033[33m'
W=$'\033[97m'
P=$'\033[35m'
D=$'\033[90m'
BLINK=$'\033[5m'
N=$'\033[0m'

# ============================================================
# TYPEWRITER EFFECT
# ============================================================

typewriter() {
    local text="$1"
    local delay=0.003

    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep "$delay"
    done

    printf "\n"
}

# ============================================================
# PROGRESS BAR
# ============================================================

progress_bar() {
    echo
    echo -e "${C}┌──────────────────────────────────────────────────────┐${N}"
    echo -e "${C}│${W}              INITIALIZING SYSTEM                   ${C}│${N}"
    echo -e "${C}└──────────────────────────────────────────────────────┘${N}"
    echo

    for i in {1..35}; do
        printf "${G}█${N}"
        sleep 0.025
    done

    echo
    echo

    for i in {0..100..10}; do
        printf "\r${Y}Loading System: ${W}%3d%%${N}" "$i"
        sleep 0.10
    done

    echo
    sleep 0.7
}

# ============================================================
# INTRO
# ============================================================

intro() {
    clear

    echo -e "${P}"
    typewriter "███╗   ██╗ ██████╗ ████████╗██████╗ ██╗   ██╗██╗  ██╗███████╗███╗   ██╗"
    typewriter "████╗  ██║██╔═══██╗╚══██╔══╝██╔══██╗╚██╗ ██╔╝██║ ██╔╝██╔════╝████╗  ██║"
    typewriter "██╔██╗ ██║██║   ██║   ██║   ██████╔╝ ╚████╔╝ █████╔╝ █████╗  ██╔██╗ ██║"
    typewriter "██║╚██╗██║██║   ██║   ██║   ██╔══██╗  ╚██╔╝  ██╔═██╗ ██╔══╝  ██║╚██╗██║"
    typewriter "██║ ╚████║╚██████╔╝   ██║   ██║  ██║   ██║   ██║  ██╗███████╗██║ ╚████║"
    typewriter "╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝"
    echo -e "${N}"

    echo
    typewriter "${C}◆ NotRyxenYT SERVER TOOLKIT ◆${N}"
    echo

    progress_bar

    clear
}

# ============================================================
# HEADER
# ============================================================

display_header() {
    clear

    echo -e "${P}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║                    NotRyxenYT                               ║"
    echo "║                 SERVER TOOLKIT                              ║"
    echo "║                                                            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${N}"

    echo -e "${C}  System Management • VPS • Pterodactyl • Cloudflare${N}"
    echo -e "${D}  ──────────────────────────────────────────────────────────${N}"
    echo
}

header() {
    echo -e "${P}${BLINK}◆ NotRyxenYT SERVER TOOLKIT ◆${N}"
    echo -e "${Y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
    echo
}

pause() {
    echo
    read -p "${W}Press [Enter] to return...${N}" dummy
}

# ============================================================
# DISCORD SERVERS
# ============================================================

discord_menu() {
    while true; do
        clear

        echo -e "${P}"
        echo "╔══════════════════════════════════════════════════════════════╗"
        echo "║                     DISCORD SERVERS                         ║"
        echo "╚══════════════════════════════════════════════════════════════╝"
        echo -e "${N}"

        echo -e "${C}  [1]${N} ${W}PrimeCloud | IT Solutions${N}"
        echo -e "      ${G}https://discord.gg/erYrFrs8RM${N}"
        echo

        echo -e "${C}  [2]${N} ${W}NotRyxenYT Offical Discord Server${N}"
        echo -e "      ${G}https://discord.gg/hAkBZkbCF6${N}"
        echo

        echo -e "${R}  [0]${N} ${W}Back${N}"
        echo

        read -p "${Y}Select server [0-2]: ${N}" dc_choice

        case "$dc_choice" in
            1)
                echo
                echo -e "${G}PrimeCloud | IT Solutions${N}"
                echo -e "${W}https://discord.gg/erYrFrs8RM${N}"
                pause
                ;;
            2)
                echo
                echo -e "${G}NotRyxenYT Offical Discord Server${N}"
                echo -e "${W}https://discord.gg/hAkBZkbCF6${N}"
                pause
                ;;
            0)
                break
                ;;
            *)
                echo -e "${R}Invalid Option!${N}"
                sleep 1
                ;;
        esac
    done
}

# ============================================================
# PTERODACTYL MENU
# ============================================================

ptero_menu() {
    while true; do
        clear

        echo -e "${P}"
        echo "╔══════════════════════════════════════════════════════════════╗"
        echo "║              PTERODACTYL CONTROL CENTER                     ║"
        echo "║                         v2.1                                ║"
        echo "╚══════════════════════════════════════════════════════════════╝"
        echo -e "${N}"

        echo -e "${C}  [1]${N} Install Panel"
        echo -e "${C}  [2]${N} Create User"
        echo -e "${C}  [3]${N} Update Panel"
        echo -e "${C}  [4]${N} Install SSL"
        echo -e "${C}  [5]${N} Uninstall Panel"
        echo -e "${R}  [0]${N} Back to Main Menu"
        echo

        read -p "${Y}Select option: ${N}" opt

        case "$opt" in
            1)
                bash <(curl -fsSL https://raw.githubusercontent.com/nobita329/ptero/main/ptero/panel/pterodactyl/install.sh)
                read -p "Press Enter..."
                ;;

            2)
                cd /var/www/pterodactyl 2>/dev/null &&
                    php artisan p:user:make
                read -p "Press Enter..."
                ;;

            3)
                cd /var/www/pterodactyl || {
                    echo -e "${R}Panel not installed!${N}"
                    sleep 2
                    continue
                }

                php artisan down

                curl -Lo panel.tar.gz \
                    https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz

                tar -xzvf panel.tar.gz

                COMPOSER_ALLOW_SUPERUSER=1 \
                    composer install --no-dev --optimize-autoloader

                php artisan migrate --seed --force
                php artisan up

                read -p "Press Enter..."
                ;;

            4)
                bash <(curl -fsSL https://raw.githubusercontent.com/nobita329/ptero/main/ptero/panel/pterodactyl/ssl.sh)
                read -p "Press Enter..."
                ;;

            5)
                rm -rf /var/www/pterodactyl
                echo -e "${G}Panel Removed.${N}"
                sleep 2
                ;;

            0)
                break
                ;;

            *)
                echo -e "${R}Invalid option${N}"
                sleep 1
                ;;
        esac
    done
}

# ============================================================
# START
# ============================================================

intro

# ============================================================
# MAIN MENU
# ============================================================

while true; do

    display_header
    header

    echo -e "${C}  1)${N} ${W}💬 Discord Servers${N}"
    echo -e "${C}  2)${N} ${W}🐋 Proxmox VE (Docker) Install${N}"
    echo -e "${C}  3)${N} ${W}🕹️ VM/KVM Installer${N}"
    echo -e "${C}  4)${N} ${W}🖥️ Pterodactyl Panel Installer${N}"
    echo -e "${C}  5)${N} ${W}🪽 Wings Installer${N}"
    echo -e "${C}  6)${N} ${W}🎨 Blueprint + Addon Installer${N}"
    echo -e "${C}  7)${N} ${W}☁️ Cloudflare Tunnel Manager${N}"
    echo -e "${C}  8)${N} ${W}🛠️ Main Tools${N}"
    echo -e "${R}  0)${N} ${W}🛑 Exit System${N}"

    echo
    echo -e "${D}──────────────────────────────────────────────────────────────${N}"
    echo

    read -p "${Y}NotRyxenYT@server:~# ${N}" choice

    case "$choice" in

        # ====================================================
        # 1 - DISCORD
        # ====================================================

        1)
            discord_menu
            ;;

        # ====================================================
        # 2 - PROXMOX
        # ====================================================

        2)
            echo -e "${C}Starting Proxmox VE container...${N}"

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

        # ====================================================
        # 3 - VM/KVM
        # ====================================================

        3)
            bash <(curl -fsSL \
                https://raw.githubusercontent.com/vpscreate123-web/mainnemu/main/Mainmenu)

            pause
            ;;

        # ====================================================
        # 4 - PTERODACTYL
        # ====================================================

        4)
            ptero_menu
            ;;

        # ====================================================
        # 5 - WINGS
        # ====================================================

        5)
            bash <(curl -fsSL \
                https://raw.githubusercontent.com/nobita329/ptero/main/ptero/wings/install.sh)

            pause
            ;;

        # ====================================================
        # 6 - BLUEPRINT
        # ====================================================

        6)

            PT_DIR="/var/www/pterodactyl"

            clear

            echo -e "${B}"
            echo "╔══════════════════════════════════════════════════════════════╗"
            echo "║             BLUEPRINT v3.0 AUTO INSTALLER                   ║"
            echo "║                  INSTALL + FIX                              ║"
            echo "╚══════════════════════════════════════════════════════════════╝"
            echo -e "${N}"

            if [ "$EUID" -ne 0 ]; then
                echo -e "${R}Error: Please run as root.${N}"
                pause
                continue
            fi

            echo -e "${Y}Target Directory:${N} ${C}$PT_DIR${N}"
            echo
            echo -e "${W}Starting automated sequence...${N}"
            sleep 2

            echo
            echo -e "${B}[1/7]${N} Checking Environment..."

            if [ ! -d "$PT_DIR" ]; then
                echo -e "${R}Pterodactyl directory not found!${N}"
                pause
                continue
            fi

            echo -e "${G}✔ Pterodactyl found.${N}"

            echo
            echo -e "${B}[2/7]${N} Installing Dependencies..."

            apt update -y -q
            apt install -y \
                curl wget unzip ca-certificates git gnupg zip -q

            echo -e "${G}✔ System packages ready.${N}"

            echo
            echo -e "${B}[3/7]${N} Setting up Node.js 20 & Yarn..."

            mkdir -p /etc/apt/keyrings

            curl -fsSL \
                https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
                | gpg --dearmor \
                -o /etc/apt/keyrings/nodesource.gpg

            echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
                > /etc/apt/sources.list.d/nodesource.list

            apt update -y -q
            apt install -y nodejs -q
            npm i -g yarn

            echo -e "${G}✔ Node environment ready.${N}"

            echo
            echo -e "${B}[4/7]${N} Downloading Blueprint Framework..."

            cd "$PT_DIR"

            DOWNLOAD_URL=$(curl -s \
                https://api.github.com/repos/BlueprintFramework/framework/releases/latest \
                | grep 'browser_download_url' \
                | grep 'release.zip' \
                | cut -d '"' -f 4)

            if [ -z "$DOWNLOAD_URL" ]; then
                echo -e "${R}Could not find Blueprint release.${N}"
                pause
                continue
            fi

            wget -q "$DOWNLOAD_URL" \
                -O "$PT_DIR/release.zip"

            unzip -o -q release.zip

            echo -e "${G}✔ Files extracted.${N}"

            echo
            echo -e "${B}[5/7]${N} Configuring Blueprint..."

            cat <<EOF > "$PT_DIR/.blueprintrc"
WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";
EOF

            chmod +x "$PT_DIR/blueprint.sh" 2>/dev/null

            echo -e "${G}✔ Configuration applied.${N}"

            echo
            echo -e "${B}[6/7]${N} Running Internal Installer..."

            bash "$PT_DIR/blueprint.sh"

            echo
            echo -e "${B}[7/7]${N} Running Auto-Fix Diagnostics..."

            echo -e "${Y}➜ Fixing Permissions...${N}"

            chown -R www-data:www-data "$PT_DIR"

            find "$PT_DIR" -type d -exec chmod 755 {} \;
            find "$PT_DIR" -type f -exec chmod 644 {} \;

            chmod +x \
                "$PT_DIR/artisan" \
                "$PT_DIR/blueprint.sh" \
                2>/dev/null

            echo -e "${Y}➜ Ensuring Yarn Dependencies...${N}"

            cd "$PT_DIR"
            yarn install --production --silent

            echo -e "${Y}➜ Clearing Panel Cache...${N}"

            php artisan view:clear
            php artisan config:clear
            php artisan route:clear

            echo
            echo -e "${G}══════════════════════════════════════════════════════════════${N}"
            echo -e "${G}              COMPLETED SUCCESSFULLY!${N}"
            echo -e "${W}        Blueprint installed and cache cleared.${N}"
            echo -e "${G}══════════════════════════════════════════════════════════════${N}"

            pause
            ;;

        # ====================================================
        # 7 - CLOUDFLARE
        # ====================================================

        7)

            clear

            RED='\033[0;31m'
            GREEN='\033[0;32m'
            YELLOW='\033[0;33m'
            BLUE='\033[0;34m'
            PURPLE='\033[0;35m'
            CYAN='\033[0;36m'
            WHITE='\033[1;37m'
            GRAY='\033[0;90m'
            NC='\033[0m'

            show_header() {
                clear

                local s_status="${GRAY}NOT INSTALLED${NC}"
                local s_pid="${GRAY}---${NC}"
                local s_uptime="${GRAY}---${NC}"
                local arch

                arch=$(dpkg --print-architecture 2>/dev/null || uname -m)

                if command -v cloudflared &>/dev/null; then
                    if systemctl is-active --quiet cloudflared; then
                        s_status="${GREEN}ACTIVE (RUNNING)${NC}"
                        s_pid="${WHITE}$(pgrep -x cloudflared)${NC}"
                        s_uptime="$(systemctl show \
                            -p ActiveEnterTimestamp cloudflared \
                            | cut -d'=' -f2)"
                    else
                        s_status="${RED}INACTIVE (STOPPED)${NC}"
                    fi
                fi

                echo -e "${PURPLE}"
                echo "┌────────────────────────────────────────────────────────────┐"
                echo "│                  CLOUDFLARED MANAGER                      │"
                echo "│                    NotRyxenYT                              │"
                echo "└────────────────────────────────────────────────────────────┘"
                echo -e "${NC}"

                echo -e "${CYAN}SYSTEM STATUS${NC}"
                echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"

                echo -e "Architecture : ${WHITE}$arch${NC}"
                echo -e "Service      : $s_status"
                echo -e "Process ID   : $s_pid"
                echo -e "Last Started : ${CYAN}$s_uptime${NC}"

                echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
                echo
            }

            step_msg() {
                echo -e "  ${CYAN}[INFO]${NC} $1..."
            }

            success_msg() {
                echo -e "  ${GREEN}[DONE]${NC} $1"
            }

            error_msg() {
                echo -e "  ${RED}[FAIL]${NC} $1"
            }

            install_cf() {

                show_header

                echo -e "${WHITE}STARTING INSTALLATION SEQUENCE${NC}"
                echo

                step_msg "Configuring Cloudflare Repository"

                mkdir -p --mode=0755 /usr/share/keyrings

                curl -fsSL \
                    https://pkg.cloudflare.com/cloudflare-main.gpg \
                    | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

                echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' \
                    | tee /etc/apt/sources.list.d/cloudflared.list >/dev/null

                success_msg "Repository Added"

                step_msg "Updating APT & Installing Binary"

                apt-get update -qq >/dev/null
                apt-get install -y cloudflared -qq >/dev/null 2>&1

                if command -v cloudflared &>/dev/null; then
                    success_msg "Cloudflared Binary Installed"
                else
                    error_msg "Binary Installation Failed"
                    read -p "Press Enter to return..."
                    return
                fi

                if systemctl list-units \
                    --type=service \
                    | grep -q cloudflared; then

                    step_msg "Removing conflicting services"

                    cloudflared service uninstall \
                        >/dev/null 2>&1

                    success_msg "Cleaned old service"
                fi

                echo
                echo -e "${YELLOW}"
                echo "┌────────────────────────────────────────────────────────────┐"
                echo "│                    ACTION REQUIRED                         │"
                echo "└────────────────────────────────────────────────────────────┘"
                echo -e "${NC}"

                echo -e "${GRAY}Paste your Cloudflare Tunnel token below.${NC}"
                echo -e "${GRAY}You may paste the complete cloudflared service command.${NC}"
                echo

                echo -ne "${PURPLE}➜ INPUT TOKEN:${NC} "
                read USER_TOKEN

                CLEAN_TOKEN=$(echo "$USER_TOKEN" \
                    | sed 's/sudo cloudflared service install //g' \
                    | sed 's/cloudflared service install //g' \
                    | xargs)

                if [[ -z "$CLEAN_TOKEN" ]]; then
                    error_msg "Token cannot be empty!"
                    read -p "Press Enter to return..."
                    return
                fi

                step_msg "Registering Tunnel Service"

                cloudflared service install "$CLEAN_TOKEN"

                echo
                echo -e "${CYAN}Waiting for service to initialize...${NC}"

                fo
