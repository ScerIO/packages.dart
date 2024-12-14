<!-- markdownlint-disable -->

# **<div align="center">Branch Name Lint</div>**

<div align="center">
  <img src="https://bit.ly/branch-name-lint" alt="BranchNameLint">
  <p></p>
  <p align="center"> Flexible git branch naming convention checker with some extra validating features</p>

<p align="center">
  <a href="https://pub.dev/packages/branch_name_lint">
    <img src="https://img.shields.io/pub/v/branch_name_lint.svg"
         alt="Pub">
  </a>
</p>

</div>

<!-- markdownlint-enable -->

## Usage

### Installation

```shell
> dart pub add --dev branch_name_lint
```

### Git hook

With [husky](https://pub.dev/packages/husky) (a tool for managing git hooks), commitlint cli can be used in `commmit-msg` git hook

#### Set `pre-push` hook:

```sh
dart pub add --dev husky
dart run husky install
dart run husky set .husky/pre-push 'dart run branch_name_lint'
```

#### Make a commit:

```sh
git add .
git commit -m "Keep calm and commit"
# `dart run branch_name_lint` will run
```

> To get the most out of `commitlint` you'll want to automate it in your project lifecycle. See our [Setup guide](https://hyiso.github.io/commitlint/#/guides-setup) for next steps.

## Configuration

### Config schema

```dart
interface Config {
  pattern: String;
  params: Record<String, String[]>;
  prohibited: String[];
  allowed: String[];
}
```

### User provided configuration

Under the hood **BranchNameLint** uses [cosmicconfig](https://www.npmjs.com/package/cosmiconfig)
to load its configuration.

You can create one of the following:

- `branch_name_lint` property in the `pubspec.yaml` file
- Extensionless "rc file" in `.yaml` format
  - `branch_name_lint`
- "rc file" with `.json` or `.yaml` extensions
  - `branch_name_lint.yaml`
  - `branch_name_lint.dart`
- ".config.dart" file
  - `branch_name_lint.config.dart`

Moreover, these filenames support dot as the first char start's writing (like `.branch_name_lint.yaml`)

> don't forget to do `final config = Config.create{...}` in `.dart` config files

**BranchNameLint** will merge found configuration with its defaults.

### Default configuration

```yaml
pattern: ":type/:task_:description"

params:
  type:
    - feature
    - fix
    - hotfix
    - release
  task: "[0-9]+"
  description: "[a-z0-9-]+"
prohibited:
  - 'master'
  - 'ci'
allowed:
  - test
```

### Linting

**BranchNameLint** uses [path-to-regexp](https://www.npmjs.com/package/path-to-regexp)
to check if branch name matches the `pattern` provided in config.

Firstly branch name will be checked if its `prohibited` or not. On the next step,
if `params` are provided, `pattern` parts will be modified/populated using
respective keys. For example:

```text
(default configuration)
:type/:name => :type(feature|fix|misc|docs)/:name([a-z0-9-]+)
```

Please refer to [path-to-regexp](https://www.npmjs.com/package/path-to-regexp)
docs for advanced patterns.

## Configuration recipes

### Only check for protected branches

```yaml
pattern:

params:

prohibited: 
  - master
  - main
  - build
  - test
  - wip
  - ci
  - release
```

### Always allow whitelist branches

```yaml
pattern: ":type/:task"

params:
  type: [ feature, release, hotfix, fix]
  task: "[0-9]+"

allowed: 
  - main
  - development
  - ci
```

### Dot-separated username & issue id

`example/branch_name_lint_example.dart`

```dart
import 'package:branch_name_lint/branch_name_lint.dart';

final config = Config.create((context) => {
  'pattern': ':username:type/:issue',
  'params': {
    'type': [
      'feature',
      'fix',
      'misc',
      'docs',
    ],
    'issue': ['lbn-[a-z0-9-]+'],
  },
  'prohibited': [
    'main',
  ],
});
```

### Scopes for monorepo

`feature/my-awesome-app/yet-another-great-feature`

```text
(imaginary monorepo structure)
packages/
    app
    shared
branch_name_lint.yaml
```

```dart
import 'package:branch_name_lint/branch_name_lint.dart';

final config = Config.create((context) => {
  'pattern': ':type/:scope/:description',
  'params': {
    'type': [
      'feature',
      'fix',
      'misc',
      'docs',
    ],
    'scope': context.readDirectories('./packages'),
  },
  'prohibited': [
    'master',
    'main',
    'build',
    'test',
    'wip',
    'ci',
    'release',
  ],
});
```

## Credits

This package is dart adaptation of the [npmjs package](https://www.npmjs.com/package/@b12k/branch-name-lint)
