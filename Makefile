# Define variables
PORT := 8000

# Show help information
help:
	@echo "Available targets:"
	@echo "  style            - Generate docs/style.json from Apple Pkl configuration"
	@echo "  download         - Download index.html and style.json from data.source.coop"
	@echo "  host             - Start local web server on port $(PORT)"
	@echo "  clean            - Clean downloaded files"
	@echo "  clean-style      - Clean generated style.json"
	@echo "  generate-and-host - Generate style and start server"
	@echo "  help             - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make style       - Generate style from ColorCode.md specifications"
	@echo "  make host        - Host the current docs/ folder"
	@echo "  make download    - Download original files from data.source.coop"

# Generate style.json from Apple Pkl configuration
style:
	@echo "Generating style.json from Apple Pkl configuration..."
	pkl eval style-generation/style.pkl --format json > docs/style.json
	@echo "Style generation complete! Generated $$(wc -c < docs/style.json | tr -d ' ') bytes"

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

# Clean generated style.json
clean-style:
	@echo "Cleaning generated style.json..."
	rm -f docs/style.json

# Generate style and host
generate-and-host: style host

# Default target
default: download host
