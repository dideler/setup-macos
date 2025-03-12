# setup-macos Guidelines

## Repository Purpose
Automated setup scripts for configuring macOS with common tools, languages, and settings.

## Commands
- Run main setup: `./setup.sh`
- Run individual components: `source ./languages/ruby` or `bash ./languages/node`
- Check script syntax: `shellcheck setup.sh utils.sh languages/* package-managers/* settings/*`

## Style Guidelines
- **Shell**: Bash-compatible shell scripts
- **Error Handling**: Use `trap` for cleanup and error reporting
- **Functions**: Source common utilities from `utils.sh`
- **Formatting**: 2-space indentation, no trailing whitespace
- **Naming**: Use lowercase with hyphens for files, lowercase with underscores for functions/variables
- **Documentation**: Include comments for non-obvious operations
- **Idempotence**: Scripts should be safe to run multiple times
- **Security**: Validate user input, avoid eval, use quotes around variables

## Testing
Test changes manually by running the affected script and verifying the expected outcome.