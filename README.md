# Agenttisen ohjelmoinnin kontti

Agenttista ohjelmointia on suositeltavaa tehdä omassa virtuaalisessa ympäristössä, kuten Docker-kontissa. Näin tekoälyn pääsy koneen tiedostoihin pysyy rajattuna ja työskentely-ympäristö eriytyy selkeästi muusta järjestelmästä.

Alla olevat ohjeet auttavat sinua käynnistämään ympäristön ja yhdistämään siihen SSH:n kautta Mac-tietokoneella.

## 1) Siirry toivottuun sijaintiin ja kloonaa repositorio toivotun projektinimen alle

```bash
cd ~/toivottu-sijainti
```
```bash
git clone https://github.com/sitrafund/agenttisen-ohjelmoinnin-kontti.git toivottu-projektin-nimi
```
```bash
cd ~/toivottu-sijainti/toivottu-projektin-nimi/
```

## 2) Aja setup.sh-skripti

```bash
./setup.sh
```

Skripti luo SSH-konfiguraation ja valmistelee Claude Code -sessiotiedostot.

## 3) Käynnistä kontti Dockerilla

**Varmista, että Docker Desktop on käynnissä.**

Mikäli Docker Desktop ei ole vielä asennettu, hanki se täältä [docker.com](https://www.docker.com).

Kun Docker on asennettu, avaa macOS-terminaali, rakenna ja käynnistä kontti seuraavalla komennolla:

```bash
docker-compose up -d --build
```

Tämä rakentaa imaget ja käynnistää palvelut taustalla.

## 4) Tunnistaudu Claude Codeen macOS-terminaalissa

- Avaa macOS-terminaali ja kirjoita:

```bash
docker exec -it toivottu-projektin-nimi bash
```
```bash
claude
```

Kun authorisointi on tehty, voit aloittaa Claude Coden käytön (myös VS Codessa), ja tekoälyn pääsy rajoittuu vain kontin sisällä oleviin tiedostoihin. Claude Code -sessio tallentuu taustalla, jotta sinun ei tarvitse tunnistautua uudelleen, kun käynnistät kontin uudelleen.

## 5) Yhdistä VS Code konttiin SSH:lla

- Asenna VS Code -laajennus **Remote - SSH**. [Lisätietoja Remote - SSH -laajennuksesta](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh).
- Avaa **Remote Explorer** -välilehti VS Codessa
- Yhdistä kohteeseen `toivottu-projektin-nimi`. Ellet näe tätä, virkistä näkymä.
- Valitse sijainti **Explorer**-välilehti -> **Open Folder** -> `/root/project`
- Paina OK

## 6) Aloita Claude Coden käyttö VS Code:lla

- Käynnistä VS Code:n terminaali ja kirjoita

```bash
claude
```

## 7) Kokeile - Pyydä Claudea luomaan peli

```bash
Luo ristinolla-peli porttiin 3000
```

Kontissa on valmiiksi projektikansio sijainnissa `/root/project/`, joka on mountattu — sen sisältö säilyy, vaikka kontti sammutetaan.

Onnea ohjelmointiin 🤖

# Lisätietoja

## Miten Claude Code -sessio tallennetaan?

Claude Code -sessio perustuu sessiotiedostoihin, jotka tulee tallentaa kontin ulkopuolelle, jotta sessio säilyy, kun kontti sammutetaan.

Synkronoituvat Claude Code -sessiotiedostot ovat seuraavat:

#### Kontin sisäpuolella

- `/root/.claude`
- `/root/.claude.json`
- `/root/project/.claude`

#### Isäntäkoneella (kontin ulkopuolella)

- `conf/claude-code-session-tallennus/.claude`
- `conf/claude-code-session-tallennus/.claude.json`
- `project/.claude`

## Miten avaan HTTP-portteja konttiin?

Lähtökohtaisesti Docker-konttiin on avattu kaksi porttia:

- `2222` SSH-yhteydelle
- `3000` verkko-ohjelmalle

Portteja voi avata lisää seuraavasti, esim. portti `5000`:

- Avaa `docker-compose.yml` -tiedosto
- Jatka porttilistaa `- "5000:5000"` -rivillä
- Avaa `Dockerfile`-tiedosto
- Muunna `EXPOSE 22 3000` muotoon `EXPOSE 22 3000 5000`
- Käynnistä Docker-kontti uudelleen 
  - `docker-compose down && docker-compose up -d --build`
- Portti `5000` on nyt tarjolla