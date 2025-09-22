# GitHub Actions Labs

This repository contains comprehensive example templates for creating GitHub Actions workflows. Each example demonstrates different use cases and best practices for CI/CD automation.

## 🚀 Available Workflow Examples

### Basic Workflows

#### [basic-ci.yml](.github/workflows/basic-ci.yml)
A simple CI workflow that demonstrates basic GitHub Actions concepts:
- Checkout code
- Basic environment setup
- System information display
- Triggered on push and pull requests

#### [nodejs-ci.yml](.github/workflows/nodejs-ci.yml)
Complete Node.js CI pipeline with:
- Matrix testing across multiple Node.js versions (16.x, 18.x, 20.x)
- Dependency caching
- Linting, testing, and building
- Artifact upload for test results

#### [python-ci.yml](.github/workflows/python-ci.yml)
Python CI workflow featuring:
- Matrix testing across Python versions (3.8, 3.9, 3.10, 3.11)
- Flake8 linting
- Pytest with coverage
- Codecov integration

### Build & Deployment

#### [docker-build.yml](.github/workflows/docker-build.yml)
Docker build and push workflow with:
- Multi-platform builds (linux/amd64, linux/arm64)
- Container registry integration (GitHub Container Registry)
- Metadata extraction and tagging
- Build caching optimization

#### [deploy.yml](.github/workflows/deploy.yml)
AWS deployment workflow including:
- S3 deployment
- CloudFront invalidation
- Environment-specific deployments
- Slack notifications
- Manual deployment triggers

#### [release.yml](.github/workflows/release.yml)
Automated release workflow with:
- Automatic changelog generation
- Asset building and packaging
- GitHub release creation
- Tag-based triggering

### Advanced Workflows

#### [matrix-build.yml](.github/workflows/matrix-build.yml)
Advanced matrix build strategy demonstrating:
- Multi-OS builds (Ubuntu, Windows, macOS)
- Include/exclude matrix configurations
- Experimental builds
- Platform-specific steps

#### [scheduled.yml](.github/workflows/scheduled.yml)
Scheduled maintenance tasks:
- Dependency updates
- Security vulnerability checks
- Automated pull request creation
- Artifact cleanup
- Cron-based scheduling

#### [manual-dispatch.yml](.github/workflows/manual-dispatch.yml)
Manual workflow dispatch with:
- Custom input parameters
- Environment selection
- Dry run capabilities
- Input validation
- Conditional execution

### Security & Quality

#### [security-scan.yml](.github/workflows/security-scan.yml)
Comprehensive security scanning:
- Trivy vulnerability scanning
- CodeQL static analysis
- GitLeaks secret detection
- npm audit security checks
- SARIF result uploads

#### [performance.yml](.github/workflows/performance.yml)
Performance testing automation:
- Lighthouse CI for web performance
- k6 load testing
- Performance report generation
- Artifact uploads for results

## 📖 Usage

Each workflow file contains detailed comments and examples. To use these templates:

1. Copy the desired workflow file to your repository's `.github/workflows/` directory
2. Modify the configuration to match your project requirements
3. Update secrets and environment variables as needed
4. Customize triggers, branches, and conditions as appropriate

## 🔧 Configuration

Many workflows require additional configuration:

### Required Secrets
- `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY` (for AWS deployment)
- `S3_BUCKET_NAME` & `CLOUDFRONT_DISTRIBUTION_ID` (for AWS deployment)
- `SLACK_WEBHOOK` (for Slack notifications)
- `LHCI_GITHUB_APP_TOKEN` (for Lighthouse CI)

### Environment Variables
- Configure environment-specific variables in your repository settings
- Use GitHub Environments for production/staging configurations

## 🤝 Contributing

Feel free to contribute additional workflow examples or improvements to existing ones. Each example should:
- Be well-documented with comments
- Follow GitHub Actions best practices
- Include appropriate error handling
- Use the latest action versions

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
