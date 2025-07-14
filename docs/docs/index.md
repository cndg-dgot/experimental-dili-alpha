# Documentation for experimental-dili-alpha

This document provides detailed technical information about the experimental-dili-alpha mapping system, including Apple Pkl-based style generation, color specifications, and layer configurations.

## Table of Contents
- [Apple Pkl Style Generation](#apple-pkl-style-generation)
- [ColorCode.md Specifications](#colorcode-specifications)
- [Map Components](#map-components)
- [Layer Configuration](#layer-configuration)
- [Development Workflow](#development-workflow)

---

## Apple Pkl Style Generation

### Overview
The project uses [Apple Pkl](https://pkl-lang.org/) for type-safe configuration management of MapLibre GL styles. This approach provides:

- **Type Safety**: Compile-time validation of configuration
- **Modularity**: Separate configuration files for colors, sources, and layers
- **Maintainability**: Centralized color and style management
- **Documentation**: Self-documenting configuration with inline comments

### Directory Structure
```
style-generation/
├── style.pkl              # Main style orchestration
├── config/
│   ├── Colors.pkl         # Color definitions (from ColorCode.md)
│   └── Sources.pkl        # PMTiles data sources
└── layers/
    ├── BaseLayers.pkl     # Fill layers (land use, water bodies)
    ├── LinearLayers.pkl   # Line layers (roads, rivers, coastlines)
    └── PointLayers.pkl    # Point layers (buildings, landmarks)
```

### Generation Process
```bash
# Generate docs/style.json from Pkl configuration
make style

# The command executes:
pkl eval style-generation/style.pkl --format json > docs/style.json
```

---

## ColorCode Specifications

### Purpose
`ColorCode.md` serves as the authoritative color specification document, providing:

- **Bilingual Mapping**: English and Indonesian feature names
- **Color Standards**: Hex color codes for all map elements
- **Styling Guidelines**: Width, opacity, and visual styling rules
- **Cross-Reference**: Mapping between display names and technical layer IDs

### Key Color Categories

#### Fill Colors (Land Use)
- **Sea/Water Bodies**: Light Blue (#00CCFF)
- **Forest/Green Areas**: Light Green (#CCFFCC) 
- **Buildings**: Light Gray (#D9D9D9)
- **Airports**: Orange (#ff7f00)
- **Sand/Bare Land**: Beige (#FBE5D6)

#### Line Colors (Infrastructure)
- **Rivers**: Steel Blue (#4682b4)
- **Roads**: Green (#008000)
- **Coastlines**: Navy Blue (#000080) / Blue (#0000c8)
- **Bridges**: Gray (#808080)
- **Power Lines**: Red (#ff0000) / Orange (#ffa500)

### Example Mapping
| English | Indonesian | Color | Type |
|---------|------------|-------|------|
| Airport | Bandara | #ff7f00 | Fill |
| River | Sungai | #4682b4 | Line |
| Forest | Hutan | #CCFFCC | Fill |
| Road | Jalan | #008000 | Line |

---

## Map Components

### index.html

#### Purpose
The `index.html` file provides the web interface for map visualization using MapLibre GL and PMTiles libraries.

#### Key Features
- **MapLibre GL Integration**: High-performance vector map rendering
- **PMTiles Protocol**: Efficient tile delivery for large datasets
- **Navigation Controls**: Zoom, pan, and rotation controls
- **Globe Control**: 3D globe view capability
- **Responsive Design**: Adaptable to different screen sizes

#### Map Configuration
- **Center**: `[125.578778, -8.554318]` (Indonesian coastal area)
- **Zoom Level**: `16.86` (detailed view)
- **Pitch**: `60°` (3D perspective)
- **Bearing**: `-178.6°` (orientation)

### style.json

#### Purpose
The `style.json` file defines the complete visual specification for the map, generated from Apple Pkl configuration based on ColorCode.md specifications.

#### Structure
- **Version**: MapLibre GL Style Specification v8
- **Sources**: PMTiles vector data sources
- **Layers**: 46 layers covering various geographic features
- **Styling**: Colors and visual properties from ColorCode.md

#### Data Sources
All map data is served via PMTiles protocol from:
```
https://data.source.coop/smartmaps/cndg-experiment/a.pmtiles
```

---

## Layer Configuration

### Layer Types

#### Background Layer
```json
{
  "id": "background",
  "type": "background",
  "paint": {
    "background-color": "#f8f9fa"
  }
}
```

#### Fill Layers (Land Use)
Example: Sea (Laut)
```json
{
  "source": "a",
  "id": "Laut",
  "source-layer": "Laut",
  "type": "fill",
  "paint": {
    "fill-opacity": {
      "interpolate": ["linear"],
      ["zoom"],
      15: 0,
      20: 1
    },
    "fill-color": "#00CCFF"
  }
}
```

#### Line Layers (Infrastructure)
Example: River (Sungai)
```json
{
  "source": "a",
  "id": "Sungai",
  "source-layer": "Sungai", 
  "type": "line",
  "paint": {
    "line-width": {
      "interpolate": ["linear"],
      ["zoom"],
      10: 0.2,
      18: 1
    },
    "line-color": "#4682b4"
  }
}
```

#### Building Layers (3D Extrusion)
Example: 3D Buildings
```json
{
  "source": "a",
  "id": "Bangunan3D",
  "source-layer": "Bangunan",
  "type": "fill-extrusion",
  "minzoom": 16,
  "paint": {
    "fill-extrusion-color": "#D9D9D9",
    "fill-extrusion-height": 8,
    "fill-extrusion-opacity": 0.8
  }
}
```

### Zoom-Based Styling
Most layers use zoom-based interpolation for responsive visualization:

```pkl
// Pkl configuration example
paint = new {
  ["line-width"] = new Listing {
    "interpolate"
    new Listing { "linear" }
    new Listing { "zoom" }
    10    // Start zoom
    0.2   // Start width
    18    // End zoom  
    1     // End width
  }
}
```

---

## Development Workflow

### Style Generation Process
1. **Edit ColorCode.md**: Update color specifications
2. **Modify Pkl Files**: Adjust layer configurations in `style-generation/`
3. **Generate Style**: Run `make style` to create `docs/style.json`
4. **Test Locally**: Run `make host` to preview changes
5. **Commit Changes**: Git commit all configuration files

### Available Make Targets
```bash
make help              # Show all available commands
make style             # Generate style.json from Pkl
make download          # Download original files
make host              # Start development server
make clean             # Clean downloaded files
make clean-style       # Clean generated files
make generate-and-host # Generate and serve
```

### Configuration Files Hierarchy
```
ColorCode.md → Colors.pkl → style.pkl → style.json
     ↓             ↓           ↓          ↓
  Specs      Type-safe   Orchestration  Final
            Colors      Configuration   Output
```

### Best Practices
1. **Color Changes**: Always update ColorCode.md first, then Colors.pkl
2. **Layer Modifications**: Edit appropriate Pkl files in `style-generation/layers/`
3. **Testing**: Use `make style && make host` for quick iteration
4. **Version Control**: Commit Pkl configurations, not just generated JSON
5. **Documentation**: Update this file when adding new features

---

For questions about specific layer configurations or color specifications, refer to the ColorCode.md file or the inline documentation within the Pkl configuration files.

### Example Layer Configuration
```json
{
  "source": "a",
  "id": "Karang",
  "source-layer": "Karang",
  "type": "fill",
  "paint": {
    "fill-opacity": [
      "interpolate",
      ["linear"],
      ["zoom"],
      15, 0,
      20, 1
    ],
    "fill-color": "#add8e8"
  },
  "layout": {}
}
```
