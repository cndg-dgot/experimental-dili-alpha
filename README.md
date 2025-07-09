# experimental-dili-alpha

## Project Overview
experimental-dili-alpha is a simple system for downloading files from a data source and hosting them locally. This project aims to host experimental map data.

## Demo on GitHub Pages
https://cndg-dgot.github.io/experimental-dili-alpha/

## Setup Instructions
1. Install the required tools:
   - [Caddy](https://caddyserver.com/) (for local server hosting)
   - `curl` (for downloading files)

2. Clone the project repository:
   ```bash
   git clone <repository-url>
   cd experimental-dili-alpha
   ```

3. Download the necessary files:
   ```bash
   make download
   ```

## Usage
### Download Files
Use the following command to download the required files:
```bash
make download
```

### Start Local Server
Use the following command to start the local server:
```bash
make host
```
The server will start on port `8000` by default. Access it in your browser at `http://localhost:8000`.

### Cleanup
To delete the downloaded files, run:
```bash
make clean
```

## License
This project is licensed under the [CC0 License](LICENSE).

## Questions and Feedback
If you have any questions or feedback, feel free to open an issue in the repository. We welcome your input!