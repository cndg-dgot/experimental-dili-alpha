# Documentation for experimental-dili-alpha

## index.html

### Purpose
The `index.html` file is designed to display a map using the MapLibre GL and PMTiles libraries. It serves as the main entry point for rendering the map interface.

### Structure
- **HTML Elements**:
  - A `div` element with the ID `map` acts as the container for the map.
- **Libraries Used**:
  - `maplibre-gl`: A library for rendering maps.
  - `pmtiles`: A library for handling PMTiles protocol.
- **Features**:
  - Adds navigation controls and a globe control to the map.
  - Loads terrain data from the `gel` source using PMTiles.

### Data Source
The terrain data is fetched using the PMTiles protocol from the following URL:
```
https://data.source.coop/smartmaps/gel/gel.pmtiles/{z}/{x}/{y}.webp
```

---

## style.json

### Purpose
The `style.json` file defines the visual style and configuration of the map. It specifies the map's appearance, including layers, colors, and data sources.

### Structure
- **Map Settings**:
  - Center coordinates: `[125.578778, -8.554318]`
  - Zoom level: `16.86`
  - Pitch: `60`
  - Bearing: `-178.6`
- **Sources**:
  - Defines vector data using the PMTiles protocol.
  - Example source:
    ```json
    {
      "type": "vector",
      "url": "pmtiles://https://data.source.coop/smartmaps/cndg-experiment/a.pmtiles"
    }
    ```
- **Layers**:
  - `background`: Sets the background color to `#f8f9fa`.
  - `Karang`: A fill layer with zoom-dependent opacity and color (`#add8e8`).
  - `Kebun`: Another fill layer with similar settings.

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
