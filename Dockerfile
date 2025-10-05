FROM ubuntu:22.04

# Asenna tarvittavat paketit ja säädä SSH-asetukset
RUN apt-get update && apt-get install -y \
    openssh-server sudo curl git nano supervisor inotify-tools rsync \
    && mkdir /var/run/sshd \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Asenna Node.js ja Claude Code
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
&& apt-get install -y nodejs \
&& npm install -g @anthropic-ai/claude-code \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Varmista asennus
RUN claude --version

# Siirrä SSH-julkinen avain kontin sisälle (varmista, että avain on kopioitu oikeaan paikkaan, eli tämän Dockerfile-tiedoston viereen)
COPY conf/ssh/id_ed25519_agenttikontti.pub /root/.ssh/authorized_keys

# Aseta oikeudet SSH-avaimelle
RUN chmod 600 /root/.ssh/authorized_keys

# Siirrä Supervisord-konfiguraatio kontin sisälle
COPY conf/supervisord.conf /etc/supervisord.conf

# Luo supervisord-kansio ja aseta oikeudet
RUN mkdir -p /var/run/supervisord && \
    chown -R root:root /var/run/supervisord

# Siirrä Claude-session tallennus -skripti kontin sisälle
COPY conf/claude-session-tallennus/claude-session-tallennus.sh /claude-session-tallennus.sh
RUN chmod +x /claude-session-tallennus.sh

# Siirrä Claude-sessiotiedostot
COPY conf/claude-session-tallennus/.claude.json /root/.claude.json
COPY conf/claude-session-tallennus/.claude /root/.claude

# Avaa SSH-portti
EXPOSE 22 3000

# Aloituskansio
WORKDIR /root/project

# Käynnistä supervisord-palvelu
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
