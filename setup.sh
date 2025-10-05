#!/usr/bin/env bash

# Luo tyhjä .claude.json-tiedosto ja .claude-kansio
mkdir -p conf/claude-session-tallennus/.claude
echo {} > conf/claude-session-tallennus/.claude.json
echo $'\e[32m[SUCCESS] Claude-sessiotiedosto ja -kansio luotu\e[0m'

# Luo SSH-avain (ed25519)
ssh-keygen -t ed25519 -b 4096 -f conf/ssh/id_ed25519_agenttikontti -N ""
echo $'\e[32m[SUCCESS] SSH-avaimen luonti valmis\e[0m'

# Lisää SSH-yhteyskonfiguraatio
CONFIG_FILE=~/.ssh/config
HOST_ENTRY="agenttisen-ohjelmoinnin-kontti"
CURRENT_DIR=$(pwd)
IDENTITY_FILE="$CURRENT_DIR/conf/ssh/id_ed25519_agenttikontti"

if ! grep -q "Host $HOST_ENTRY" "$CONFIG_FILE"; then
  {
    echo ""
    echo "Host $HOST_ENTRY"
    echo "  HostName localhost"
    echo "  Port 2222"
    echo "  User root"
    echo "  IdentityFile $IDENTITY_FILE"
  } >> "$CONFIG_FILE"
  echo $'\e[32m[SUCCESS] SSH-yhteyskonfiguraatio luotu\e[0m'
fi

echo $'\e[32m[SUCCESS] SSH-yhteyskonfiguraatio valmis\e[0m'