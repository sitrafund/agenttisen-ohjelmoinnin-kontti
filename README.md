# Agenttisen ohjelmoinnin kontti

Agenttista ohjelmointia varten rakennettu kehitysympäristö, joka hyödyntää VS Code Dev Containersia. Tekoälyn pääsy rajoittuu kontin sisälle, ja työskentely-ympäristö on selkeästi eriytetty muusta järjestelmästä.

## Kansiorakenne

```
/
├── .devcontainer/               # Kehitysympäristön konfiguraatio
│   ├── Dockerfile               # Dev container -image
│   └── devcontainer.json        # VS Code Dev Container -asetukset
├── project/                     # Oma sovelluksesi
└── README.md
```

## Käyttöönotto

### Vaatimukset

- [Docker Desktop](https://www.docker.com)
- [VS Code](https://code.visualstudio.com)
- VS Code -laajennus: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Käynnistys

1. Kloonaa repositorio:
   ```bash
   git clone --depth 1 https://github.com/sitrafund/agenttisen-ohjelmoinnin-kontti.git projektin-nimi
   ```

2. Siirry kansioon:
   ```bash
   cd projektin-nimi
   ```

3. Avaa kansio VS Codessa:
   ```bash
   code .
   ```

4. VS Code tunnistaa `.devcontainer/`-kansion ja ehdottaa: **"Reopen in Container"** — klikkaa sitä.

5. Odota, että kontti rakentuu. Tämän jälkeen olet kehitysympäristössä.

### Claude Coden käyttö

Avaa VS Coden terminaali ja kirjoita:
```bash
claude
```

### Mistral Viben käyttö

```bash
vibe
```

### Tunnistautuminen

Ensimmäisellä kerralla sinun tulee tunnistautua. Tunnistautuminen ei välttämättä toimi VS Coden terminaalissa. Tällöin avaa Macin oma terminaali, siirry kontin sisään ja kirjoita `claude` tai `vibe`:

```bash
docker exec -it <kontin-nimi> bash
claude
```

Tunnistautumisen jälkeen sessio säilyy ja voit jatkaa VS Coden terminaalissa.

## Dev Container -ominaisuudet

Kontissa on valmiiksi asennettuna:
- Claude Code
- Mistral Vibe

## Kokeile

Pyydä Claudea tai Mistral Vibeä luomaan peli:

```
Luo ristinolla-peli project-kansioon ja porttiin 3000
```

Onnea ohjelmointiin 🤖
