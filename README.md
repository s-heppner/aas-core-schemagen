# aas-core-schemagen
Helper scripts to generate AAS schemas using the tools from [aas-core-works](https://github.com/aas-core-works/).

## DISCLAIMER
This is meant as an expert helper tool for generating the schemas 
in the development phase for a publication
by the Industrial Digital Twin Association (IDTA). 
The resulting schemas are not tested, nor in any way official.

**Use at your own risk.**

## Requirements: 

- Linux 
- Python >= 3.9

## Usage: 

1. Adapt the `.env` file with the current versions of aas-core-meta and aas-core-codegen
2. Run `bash generate_schemas.sh`