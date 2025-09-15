FROM ubuntu:22.04

# Asenna tarvittavat paketit ja säädä SSH-asetukset
RUN apt-get update && apt-get install -y \
    openssh-server sudo curl git vim \
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
COPY id_ed25519.pub /root/.ssh/authorized_keys

# Aseta oikeudet SSH-avainille
RUN chmod 600 /root/.ssh/authorized_keys

# Avaa SSH-portti
EXPOSE 22

# Käynnistä SSH-palvelu
CMD ["/usr/sbin/sshd", "-D"]
