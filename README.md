# TMY and FMY Data Generators

This repository contains two scripts for generating and processing meteorological datasets for building energy simulation and environmental modeling. The scripts support the creation of **Typical Meteorological Year (TMY)** and **Future Meteorological Year (FMY)** datasets from raw climate observations and climate model projections.

------

## Repository Structure

```
.
├── TMY-Gencode.py     # Python script for generating TMY datasets
├── FMY-Gencode.m      # MATLAB script for generating FMY datasets
└── README.md          # Project documentation
```

------

## Features

- **TMY-Gencode.py**
  - Implements TMY construction from multi-year historical weather observations.
  - Applies statistical selection methods to create a representative "typical year".
  - Outputs hourly datasets in formats compatible with building simulation software (CSV, EPW, etc.).
- **FMY-Gencode.m**
  - Generates FMY datasets based on climate change scenarios (e.g., SSP2-4.5, SSP5-8.5).
  - Uses projected meteorological data for future time horizons (e.g., 2050, 2099).
  - Outputs hourly climate data files for use in building performance and environmental analysis.

------

## Requirements

### Python (for `TMY-Gencode.py`)

- Python 3.8+
- Recommended packages:
  - `pandas`
  - `numpy`
  - `scipy`
  - `matplotlib` (optional, for visualization)

Install dependencies via:

```
pip install -r requirements.txt
```

### MATLAB (for `FMY-Gencode.m`)

- MATLAB R2021a or later
- No additional toolboxes required (unless specified in the script)

------

## Usage

### 1. Generating TMY (Python)

Run the script with historical meteorological data as input:

```
python TMY-Gencode.py --input ./raw_data/ --output ./TMY/
```

Example arguments:

- `--input`: Directory containing multi-year hourly weather records
- `--output`: Directory to save generated TMY files
- `--format`: (optional) Output format, e.g., `csv`, `epw`

------

### 2. Generating FMY (MATLAB)

Execute the script in MATLAB with climate projection datasets:

```
FMY-Gencode('input_folder', './projections/', 'output_folder', './FMY/')
```

Example arguments:

- `input_folder`: Directory with climate projection data (NetCDF or CSV)
- `output_folder`: Target directory for generated FMY files

------

## Input Data

- **TMY generation** requires multi-year historical hourly weather observations from meteorological stations.
- **FMY generation** requires downscaled climate model outputs under specific emission scenarios (e.g., SSP2-4.5, SSP5-8.5).

------

## Output Data

- Hourly weather files (8,760 records per year)
- File naming convention: `<station_id>_<scenario>_<year>.csv` (or `.epw`, `.wea` etc. depending on the format)
- Compatible with major building energy simulation software, including **EnergyPlus**, **OpenStudio**, **DeST**, and **Radiance**.

------

## Citation

If you use this repository or its generated datasets in your research, please cite:

```
[Author(s)], "[Dataset/Tool Name]: Typical and Future Meteorological Year Data Generators for Building Simulation," Zenodo, 2025. DOI: [to be added]
```

------

## License

This project is released under the **MIT License**.
 You are free to use, modify, and distribute it with attribution.