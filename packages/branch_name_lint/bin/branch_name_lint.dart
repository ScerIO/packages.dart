import 'dart:io';

import 'package:branch_name_lint/branch_name_lint.dart';

void main(List<String> arguments) async {
  const rcFileName = 'branch_name_lint';
  final config = await Config.find(rcFileName);

  try {
    (await BranchName.current(config)).lint();
  } catch (error) {
    if (error is! BranchLintError) {
      rethrow;
    }
    printError(error.toString());
    printHint(error, config);
    exit(1);
  }
}
