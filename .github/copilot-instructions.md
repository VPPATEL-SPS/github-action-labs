# GitHub Action Labs

GitHub Action Labs is a repository containing example templates and workflows for creating GitHub Actions CI/CD pipelines. The repository provides pre-built workflow templates for common scenarios including Node.js, Python, Docker builds, and basic CI patterns.

**ALWAYS reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Repository Bootstrap and Setup
- Clone the repository and navigate to the root directory
- The repository structure is minimal with workflows in `.github/workflows/`
- No external dependencies or build systems required
- All validation tools are already available in the environment

### Essential Commands (VALIDATED AND TIMED)
- **Validate all workflows**: `./validate-workflows.sh` -- takes 0.3 seconds. Use timeout of 30 seconds.
- **YAML syntax validation**: `yamllint .github/workflows/` -- takes 0.1 seconds. Use timeout of 30 seconds.
- **Python YAML parsing test**: `python3 -c "import yaml; yaml.safe_load(open('FILE.yml'))"` -- instant
- **Create new workflow**: `./create-workflow.sh <name> <template>` -- takes 0.1 seconds
- **Preview workflows**: `find .github/workflows -name "*.yml" -exec head -10 {} \;`

### CRITICAL Workflow Validation Requirements
**NEVER SKIP VALIDATION** - Always run these commands before committing any workflow changes:

1. **ALWAYS run YAML validation**: `yamllint .github/workflows/` 
2. **ALWAYS test Python parsing**: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/YOUR_FILE.yml'))"`
3. **ALWAYS run structure validation**: `./validate-workflows.sh`
4. **ALWAYS check workflow syntax**: Use `yq eval '.jobs' .github/workflows/YOUR_FILE.yml` to verify structure

### Workflow Creation Process
- Use the `./create-workflow.sh` script to create new workflows from templates
- Available templates: `basic`, `nodejs`, `python`, `docker`
- Example: `./create-workflow.sh my-api nodejs`
- **ALWAYS validate immediately after creation** using the commands above

## Validation Requirements

### Manual Validation Scenarios
After creating or modifying any workflow, **ALWAYS** perform these validation steps:

1. **YAML Syntax Check**: Run `yamllint .github/workflows/` - must pass with no errors
2. **Structure Validation**: Run `./validate-workflows.sh` - must show all checkmarks
3. **Content Review**: Verify the workflow contains:
   - `name` field
   - `on` field (trigger conditions)  
   - `jobs` field with at least one job
   - Valid action references (e.g., `actions/checkout@v4`)

### Testing Workflow Modifications
- **Syntax**: Use `yamllint` for YAML validation
- **Parsing**: Use Python YAML parsing to catch structural issues
- **Logic**: Use `yq` to extract and verify specific fields
- **Integration**: Review action versions and ensure they're current

### Required Workflow Elements
Every workflow MUST contain:
```yaml
---
name: Workflow Name

'on':
  push:
    branches: [main]

jobs:
  job-name:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
```

## Common Tasks

### Creating New Workflows
```bash
# Create basic workflow
./create-workflow.sh basic-ci basic

# Create Node.js workflow  
./create-workflow.sh nodejs-app nodejs

# Create Python workflow
./create-workflow.sh python-tests python

# Validate created workflow
./validate-workflows.sh
```

### Workflow Validation Commands
```bash
# Validate all workflows (comprehensive)
./validate-workflows.sh

# Quick YAML syntax check
yamllint .github/workflows/

# Check specific workflow structure
yq eval '.jobs | keys' .github/workflows/example.yml

# Verify action references
yq eval '.. | select(has("uses")) | .uses' .github/workflows/*.yml
```

### Repository Structure Reference
```
.
├── README.md
├── .github/
│   └── workflows/
│       ├── example-ci.yml
│       ├── nodejs-ci.yml  
│       ├── docker-build.yml
│       └── test-python.yml
├── validate-workflows.sh
└── create-workflow.sh
```

### Available Workflow Templates
- **basic**: Simple CI workflow with checkout and basic tests
- **nodejs**: Node.js CI with multiple Node versions, npm install, test, and build
- **python**: Python CI with multiple Python versions, pip install, and pytest
- **docker**: Docker build and push to GitHub Container Registry

### Common Workflow Patterns

#### Essential Actions to Use
- `actions/checkout@v4` - Repository checkout (ALWAYS use v4 or latest)
- `actions/setup-node@v4` - Node.js setup
- `actions/setup-python@v4` - Python setup  
- `docker/build-push-action@v5` - Docker build and push

#### Trigger Patterns
```yaml
# Standard push/PR triggers
'on':
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

# Tag-based releases
'on':
  push:
    tags: ['v*']
```

### Timing and Performance
- **Workflow validation**: < 1 second
- **Workflow creation**: < 1 second  
- **YAML linting**: < 1 second
- All validation commands are nearly instant - no need for extended timeouts

### Error Prevention
- **ALWAYS quote the 'on' key**: Use `'on':` not `on:` to avoid YAML truthy issues
- **ALWAYS add newlines**: End all YAML files with a newline character
- **ALWAYS use proper indentation**: 2 spaces for YAML, no tabs
- **ALWAYS validate before committing**: Run `./validate-workflows.sh`

### CI/CD Best Practices Embedded in Templates
- Use matrix strategies for multi-version testing
- Cache dependencies (npm, pip) when possible
- Use specific action versions (not @main or @latest)
- Include proper permissions for Docker registry access
- Use environment variables for configuration

### Troubleshooting Common Issues
- **YAML parsing errors**: Run `yamllint` to identify syntax issues
- **Missing action versions**: Use `@v4` or specific version tags
- **Indentation errors**: Use exactly 2 spaces, no tabs
- **Truthy warnings**: Quote the `'on'` keyword
- **Missing newlines**: Ensure files end with newline character

This repository provides a foundation for learning and implementing GitHub Actions workflows with validated, working examples that follow current best practices.