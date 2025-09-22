#!/bin/bash

# Create a new GitHub Actions workflow from template
# Usage: ./create-workflow.sh <workflow-name> <template-type>

set -e

WORKFLOW_NAME="${1:-example}"
TEMPLATE_TYPE="${2:-basic}"

if [ -z "$1" ]; then
    echo "Usage: ./create-workflow.sh <workflow-name> [template-type]"
    echo "Available templates: basic, nodejs, docker, python"
    exit 1
fi

WORKFLOWS_DIR=".github/workflows"
WORKFLOW_FILE="$WORKFLOWS_DIR/${WORKFLOW_NAME}.yml"

# Create workflows directory if it doesn't exist
mkdir -p "$WORKFLOWS_DIR"

# Check if file already exists
if [ -f "$WORKFLOW_FILE" ]; then
    echo "❌ Workflow file $WORKFLOW_FILE already exists"
    exit 1
fi

case "$TEMPLATE_TYPE" in
    "basic")
        cat > "$WORKFLOW_FILE" << 'EOF'
---
name: WORKFLOW_NAME_PLACEHOLDER

'on':
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Run tests
        run: |
          echo "Running tests for WORKFLOW_NAME_PLACEHOLDER"
          echo "Add your test commands here"
EOF
        ;;
    "nodejs")
        cat > "$WORKFLOW_FILE" << 'EOF'
---
name: WORKFLOW_NAME_PLACEHOLDER

'on':
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [18.x, 20.x]

    steps:
      - uses: actions/checkout@v4

      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build
EOF
        ;;
    "python")
        cat > "$WORKFLOW_FILE" << 'EOF'
---
name: WORKFLOW_NAME_PLACEHOLDER

'on':
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        python-version: [3.9, 3.10, 3.11]

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install pytest
          if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

      - name: Test with pytest
        run: |
          pytest
EOF
        ;;
    *)
        echo "❌ Unknown template type: $TEMPLATE_TYPE"
        echo "Available templates: basic, nodejs, docker, python"
        exit 1
        ;;
esac

# Replace placeholder with actual workflow name
sed -i "s/WORKFLOW_NAME_PLACEHOLDER/$WORKFLOW_NAME/g" "$WORKFLOW_FILE"

echo "✅ Created workflow: $WORKFLOW_FILE"
echo "📝 Template type: $TEMPLATE_TYPE"

# Validate the created workflow
echo "🔍 Validating created workflow..."
if command -v yamllint &> /dev/null; then
    yamllint "$WORKFLOW_FILE" && echo "✅ YAML validation passed"
else
    python3 -c "import yaml; yaml.safe_load(open('$WORKFLOW_FILE'))" && echo "✅ YAML parsing successful"
fi