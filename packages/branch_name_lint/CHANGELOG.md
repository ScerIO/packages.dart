## 1.1.0

### Features

- Added CLI arguments support using `args` package
  - `--branch-name` / `-b`: Override branch name (useful for CI/CD environments)
  - `--help` / `-h`: Display usage information
- Improved testability with refactored `BranchName.create()` method
- Deprecated `BranchName.current()` in favor of more flexible `BranchName.create()`

### Testing

- Added comprehensive test suite covering:
  - Configuration validation (pattern, params, allowed, prohibited)
  - Priority rules (allowed > prohibited > pattern)
  - CLI arguments handling
  - Integration scenarios for CI/CD and monorepo setups

## 1.0.0

- Initial version.
