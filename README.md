### Agenttisen ohjelmoinnin kontti

Agenttista ohjelmointia on suositeltavaa tehdä omassa virtuaalisessa ympäristössä eli esimerkiksi Docker-kontissa, jolloin tekoälyn pääsyä koneen tiedostoihin rajataan tehokkaasti.

Alla lyhyet ohjeet (Mac-koneelle) ympäristön käynnistämiseksi ja yhdistämiseksi konttiin SSH:n kautta.

### 1) Siirry työpöydälle ja kloonaa repo

```bash
cd ~/Desktop
git clone https://github.com/sitrafund/agenttisen-ohjelmoinnin-kontti.git
```

### 2) Luo SSH-avain (ed25519)

```bash
ssh-keygen -t ed25519
```
- Paina Enter hyväksyäksesi oletuspolun `~/.ssh/id_ed25519`, ja aseta halutessasi aseta salasana (passphrase).

### 3) Kopioi julkinen avain projektin juureen

```bash
cp ~/.ssh/id_ed25519.pub ~/Desktop/agenttisen-ohjelmoinnin-kontti/
```

Varmista, että tiedosto `id_ed25519.pub` löytyy projektin juuresta (`agenttisen-ohjelmoinnin-kontti`).

### 4) Käynnistä kontti Dockerilla

Mikäli Docker ei ole vielä asennettu, hanki se asentamalla esimerkiksi Docker Desktop [docker.com](https://www.docker.com).

Kun Docker on asennettu, rakenna ja käynnistä kontti.

```bash
cd ~/Desktop/agenttisen-ohjelmoinnin-kontti/
docker-compose up -d --build
```

Tämä rakentaa imaget ja käynnistää palvelut taustalla.

### 5) Lisää SSH-konfiguraatio

Lisää tämä `~/.ssh/config` -tiedostoon. Luo tiedosto, mikäli sitä ei ole.

```bash
Host agenttisen-ohjelmoinnin-kontti
  HostName localhost
  Port 2222
  User root
  IdentityFile ~/.ssh/id_ed25519
```

### 6) Asenna editorilaajennus

- **VS Code** tai **Cursor**: asenna laajennus **Remote - SSH**. [Lisätietoja Remote - SSH -laajennuksesta](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh).

### 7) Yhdistä konttiin SSH:lla

- Avaa Remote - SSH -laajennus ja lisää uusi SSH-kohde (Host) kontille.
- Yhdistä lisättyyn kohteeseen laajennuksen kautta.

Tarvittaessa päivitä yhteys- tai avainpolut oman ympäristösi mukaan.

### 8) Avaa editorin terminaalissa Claude Code

- Avaa terminaali ja kirjoita

```bash
claude
```

Nyt voit aloittaa Claude Coden käytön, ja tekoälyn pääsy rajaantuu vain kontin sisällä oleviin tiedostoihin.

Kontissa on valmiiksi projektikansio sijainnissa `/root/project/`, joka on mountattu, eli sen sisään tallennetut tiedostot säilyvät, kun kontti sammutetaan.

Onnea ohjelmointiin 🤖