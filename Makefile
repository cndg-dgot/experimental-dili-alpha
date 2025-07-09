# Define variables
PORT := 8000

# Download necessary files
download:
	@echo "Downloading files..."
	curl -f -o docs/index.html https://data.source.coop/smartmaps/cndg-experiment/index.html || (echo "Failed to download index.html" && exit 1)
	curl -f -o docs/style.json https://data.source.coop/smartmaps/cndg-experiment/style.json || (echo "Failed to download style.json" && exit 1)

# Host the files locally
host:
	@echo "Starting local server on port $(PORT)..."
	caddy file-server --root docs --listen :$(PORT)

# Clean downloaded files
clean:
	@echo "Cleaning up downloaded files..."
	rm -f docs/index.html docs/style.json

# Default target
default: download host
