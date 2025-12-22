import 'dart:io';

import 'package:args/args.dart';
import 'package:branch_name_lint/branch_name_lint.dart';

const String version = '1.1.0';

ArgParser buildParser() {
  return ArgParser()
    ..addOption(
      'branch-name',
      abbr: 'b',
      help: 'Override branch name (useful for CI/CD environments)',
      valueHelp: 'name',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Display this help information',
    );
}

void printUsage(ArgParser parser) {
  print('Branch Name Lint v$version');
  print('');
  print('Usage: dart run branch_name_lint [options]');
  print('');
  print('Options:');
  print(parser.usage);
  print('');
  print('Examples:');
  print('  dart run branch_name_lint');
  print('  dart run branch_name_lint --branch-name feature/my-feature');
  print('  dart run branch_name_lint -b \$CI_BRANCH_NAME');
}

void main(List<String> arguments) async {
  final parser = buildParser();
  
  try {
    final results = parser.parse(arguments);
    
    if (results['help'] as bool) {
      printUsage(parser);
      exit(0);
    }
    
    const rcFileName = 'branch_name_lint';
    final config = await Config.find(rcFileName);
    final branchName = results['branch-name'] as String?;

    try {
      (await BranchName.create(config, branchName: branchName)).lint();
    } catch (error) {
      if (error is! BranchLintError) {
        rethrow;
      }
      printError(error.toString());
      printHint(error, config);
      exit(1);
    }
  } on FormatException catch (e) {
    print('Error: ${e.message}');
    print('');
    printUsage(parser);
    exit(1);
  }
}
