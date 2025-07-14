# Style Generation

This directory contains Apple Pkl configurations for generating MapLibre GL styles for the experimental-dili-alpha project.

## Structure

```
style-generation/
├── style.pkl                    # Main style configuration
├── config/
│   ├── Colors.pkl              # Color palette definitions
│   └── Sources.pkl             # Data source configurations
└── layers/
    ├── BaseLayers.pkl          # Background and base polygon layers
    ├── LinearLayers.pkl        # Line features (roads, rivers, etc.)
    └── PointLayers.pkl         # Point features and buildings
```

## Usage

### Generate style.json
```bash
make generate-style
```

### Validate Pkl configuration
```bash
make validate-pkl
```

### Build everything (including style generation)
```bash
make build
```

## Dependencies

- **Apple Pkl**: Configuration language for type-safe style generation
  - Install: https://pkl-lang.org/main/current/pkl-cli/index.html

## Configuration

### Colors
Color palette is defined in `config/Colors.pkl` with organized color schemes for:
- Water features
- Natural features (vegetation, sand, etc.)
- Infrastructure (buildings, roads, etc.)
- Administrative boundaries

### Sources
Data sources are configured in `config/Sources.pkl`:
- PMTiles vector source from source.optgeo.org
- Terrain data (gel) for 3D elevation

### Layers
Layer definitions are organized by type:
- **BaseLayers.pkl**: Background, water surfaces, vegetation
- **LinearLayers.pkl**: Rivers, roads, and other linear features
- **PointLayers.pkl**: Buildings (2D/3D) and point features

## Benefits

- **Type Safety**: Compile-time validation of MapLibre GL style properties
- **Modularity**: Separate concerns (colors, layers, sources) into focused modules
- **Maintainability**: Easy to update colors, layer ordering, or styling rules
- **Documentation**: Self-documenting configuration with built-in comments
- **Validation**: Early error detection before runtime
