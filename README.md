# experimental-dili-alpha

## Project Overview
experimental-dili-alpha is a MapLibre GL-based mapping system with Apple Pkl-based style generation. This project provides experimental map visualization for Indonesian coastal and inland features with bilingual (English/Indonesian) layer mapping.

## Demo on GitHub Pages
https://cndg-dgot.github.io/experimental-dili-alpha/

## PMTiles.io Viewer
https://pmtiles.io/#url=https%3A%2F%2Fpmtiles.optgeo.org%2Fcndg-experiment.json&map=17.53/-8.55425/125.578644

## Features
- **Apple Pkl-based Style Generation**: Type-safe configuration management for MapLibre GL styles
- **ColorCode.md Specifications**: Centralized color and styling documentation with English/Indonesian mapping
- **PMTiles Protocol Support**: Efficient vector tile delivery
- **Bilingual Layer Support**: Feature names in both English and Indonesian
- **Local Development Server**: Built-in Caddy server for development

## Setup Instructions
1. Install the required tools:
   - [Apple Pkl](https://pkl-lang.org/) (for style generation)
   - [Caddy](https://caddyserver.com/) (for local server hosting)
   - `curl` (for downloading files)

2. Clone the project repository:
   ```bash
   git clone <repository-url>
   cd experimental-dili-alpha
   ```

## Usage

### Generate Style from Apple Pkl Configuration
Generate `docs/style.json` from the ColorCode.md specifications:
```bash
make style
```

### Download Original Files
Download files from the original data source:
```bash
make download
```

### Start Local Server
Start the local development server:
```bash
make host
```
The server will start on port `8000` by default. Access it at `http://localhost:8000`.

### Combined Operations
Generate style and start server in one command:
```bash
make generate-and-host
```

### Cleanup
Delete downloaded files:
```bash
make clean
```

Delete generated style files:
```bash
make clean-style
```

View all available commands:
```bash
make help
```

## Project Structure
```
├── ColorCode.md              # Color specifications (EN/ID mapping)
├── docs/
│   ├── index.html             # Map viewer interface
│   ├── style.json             # MapLibre GL style (generated)
│   └── docs/
│       └── index.md           # Detailed documentation
├── style-generation/
│   ├── style.pkl              # Main style configuration
│   ├── config/
│   │   ├── Colors.pkl         # Color definitions
│   │   └── Sources.pkl        # Data source definitions
│   └── layers/
│       ├── BaseLayers.pkl     # Fill and background layers
│       ├── LinearLayers.pkl   # Line layers (roads, rivers, etc.)
│       └── PointLayers.pkl    # Point and building layers
├── Makefile                   # Build automation
└── README.md                  # This file
```

## Documentation
For detailed documentation about the map layers, color specifications, and technical implementation, see [docs/docs/](docs/docs/).

## License
This project is licensed under the [CC0 License](LICENSE).

## Questions and Feedback
If you have any questions or feedback, feel free to open an issue in the repository. We welcome your input!