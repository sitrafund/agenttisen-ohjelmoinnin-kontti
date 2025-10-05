### Agenttisen ohjelmoinnin kontti

Agenttista ohjelmointia on suositeltavaa tehdä omassa virtuaalisessa ympäristössä eli esimerkiksi Docker-kontissa, jolloin tekoälyn pääsyä koneen tiedostoihin rajataan tehokkaasti.

Alla lyhyet ohjeet (Mac-koneelle) ympäristön käynnistämiseksi ja yhdistämiseksi konttiin SSH:n kautta.

### 1) Siirry työpöydälle ja kloonaa repo

```bash
cd ~/toivottu-sijainti
git clone https://github.com/sitrafund/agenttisen-ohjelmoinnin-kontti.git
cd ~/toivottu-sijainti/agenttisen-ohjelmoinnin-kontti/
```

### 2) Aja setup.sh-skripti

```bash
./setup.sh
```

### 3) Käynnistä kontti Dockerilla

Mikäli Docker ei ole vielä asennettu, hanki se asentamalla esimerkiksi Docker Desktop [docker.com](https://www.docker.com).

Kun Docker on asennettu, avaa terminaali, rakenna ja käynnistä kontti seuraavalla komennolla.

```bash
docker-compose up -d --build
```

Tämä rakentaa imaget ja käynnistää palvelut taustalla.

### 4) Asenna VS Code -laajennus

- **VS Code** asenna laajennus **Remote - SSH**. [Lisätietoja Remote - SSH -laajennuksesta](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh).

### 5) Yhdistä VS Code konttiin SSH:lla

- Avaa Remote Explorer -välilehti VS Codessa
- Yhdistä kohteeseen `agenttisen-ohjelmoinnin-kontti`. Ellet näe tätä, virkistä näkymä.

### 6) Avaa editorin terminaalissa Claude Code

- Avaa terminaali ja kirjoita

```bash
claude
```

#### Huomio - Ongelma authorisoinnin kanssa
Mikäli VS Coden terminaalissa ilmenee yhteysongelmia Clauden authorisoinnin kanssa, tee authorisointi macOS terminaalissa seuraavasti:

- Siirry kontin sisälle tällä komennolla:

```bash
docker exec -it agenttisen-ohjelmoinnin-kontti bash
```

- Aloita authorisointi Claude Codeen, ja seuraa ohjeita

```bash
claude
```

Nyt voit aloittaa Claude Coden käytön (myös VS Codessa), ja tekoälyn pääsy rajoittuu vain kontin sisällä oleviin tiedostoihin. Claude Code -sessio tallentuu taustalla, jotta sinun ei tarvitse tunnistautua uudelleen, kun käynnistät kontin uudelleen.

Kontissa on valmiiksi projektikansio sijainnissa `/root/project/`, joka on mountattu, eli sen sisään tallennetut tiedostot säilyvät, kun kontti sammutetaan.

Onnea ohjelmointiin 🤖