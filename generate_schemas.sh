#!/bin/bash

# Read in variables
source .env
echo "Generate schemas using"
echo "    aas-core-meta@    ${AAS_CORE_META_COMMIT}"
echo "    aas-core-codegen@ ${AAS_CORE_CODEGEN_COMMIT}"
echo ""

# Generate a new Python virtual environment
python3 -m venv venv-codegen
source venv-codegen/bin/activate
which python3

# Pull repositories
mkdir -p ./temp
mkdir -p "${OUTPUT_DIR}"
cd ./temp || return 1
git clone https://github.com/aas-core-works/aas-core-meta.git
cd ./aas-core-meta || return 1
git checkout "${AAS_CORE_META_COMMIT}"

# Install dependencies
pip install git+https://github.com/aas-core-works/aas-core-codegen@"${AAS_CORE_CODEGEN_COMMIT}"

# Generate schemas
echo "Generate JSON Schema"
aas-core-codegen \
  --model_path "${AAS_CORE_META_MODEL_FILE}" \
  --snippets_dir "../../${SNIPPETS_DIR}"/jsonschema \
  --output_dir "../../${OUTPUT_DIR}" \
  --target jsonschema

echo "Generate XSD"
aas-core-codegen \
  --model_path "${AAS_CORE_META_MODEL_FILE}" \
  --snippets_dir "../../${SNIPPETS_DIR}"/xsd \
  --output_dir "../../${OUTPUT_DIR}" \
  --target xsd

echo "Generate RDFS"
aas-core-codegen \
  --model_path "${AAS_CORE_META_MODEL_FILE}" \
  --snippets_dir "../../${SNIPPETS_DIR}"/rdf \
  --output_dir "../../${OUTPUT_DIR}" \
  --target rdf_shacl

echo "Generate Python"
aas-core-codegen \
  --model_path "${AAS_CORE_META_MODEL_FILE}" \
  --snippets_dir "../../${SNIPPETS_DIR}"/Python \
  --output_dir "../../${OUTPUT_DIR}/Python" \
  --target python

# Clean up
cd ../..
rm -rf ./temp
rm -r ./venv-codegen
