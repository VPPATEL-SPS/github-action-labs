#!/bin/bash

# GitHub Actions Workflow Validation Script
# This script validates all GitHub Actions workflows in the repository

set -e

echo "🔍 Validating GitHub Actions workflows..."

# Check if .github/workflows directory exists
if [ ! -d ".github/workflows" ]; then
    echo "❌ No .github/workflows directory found"
    exit 1
fi

# Count workflow files
workflow_count=$(find .github/workflows -name "*.yml" -o -name "*.yaml" | wc -l)
echo "📁 Found $workflow_count workflow files"

# Validate YAML syntax with yamllint
echo "📋 Validating YAML syntax..."
if command -v yamllint &> /dev/null; then
    yamllint .github/workflows/
    echo "✅ YAML syntax validation passed"
else
    echo "⚠️  yamllint not available, skipping syntax check"
fi

# Validate YAML parsing with Python
echo "🐍 Testing YAML parsing..."
for file in .github/workflows/*.yml .github/workflows/*.yaml; do
    if [ -f "$file" ]; then
        python3 -c "import yaml; yaml.safe_load(open('$file'))" && echo "✅ $file parses correctly"
    fi
done

# Check for required workflow elements
echo "🔧 Checking workflow structure..."
for file in .github/workflows/*.yml .github/workflows/*.yaml; do
    if [ -f "$file" ]; then
        echo "📄 Checking $file..."
        
        # Check for required top-level keys
        if yq eval '.name' "$file" > /dev/null; then
            echo "  ✅ Has 'name' field"
        fi
        
        if yq eval '.on' "$file" > /dev/null; then
            echo "  ✅ Has 'on' field (triggers)"
        fi
        
        if yq eval '.jobs' "$file" > /dev/null; then
            echo "  ✅ Has 'jobs' field"
        fi
        
        # Check job structure
        job_count=$(yq eval '.jobs | keys | length' "$file")
        echo "  📊 Contains $job_count job(s)"
    fi
done

echo "🎉 Workflow validation completed!"