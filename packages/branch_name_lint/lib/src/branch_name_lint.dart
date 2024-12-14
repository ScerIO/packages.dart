import 'dart:io';

import 'package:branch_name_lint/src/config.dart';
import 'package:branch_name_lint/src/errors.dart';

class BranchName {
  final Config config;
  final String branchName;

  const BranchName._(this.config, this.branchName);

  /// Checks the branch name
  bool lint() {
    var pattern = config.pattern;
    final params = config.params;
    final prohibited = config.prohibited;
    final allowed = config.allowed;

    // Check for allowed branches
    if (allowed.contains(branchName)) return true;

    // Check for prohibited branches
    if (prohibited.contains(branchName)) throw branchProtectedError;

    // If the pattern is not set, skip
    if (pattern.isEmpty) return true;

    // Form a regex by substituting parameters
    params.forEach((key, values) {
      final group = values.join('|');
      pattern = pattern.replaceAll(':$key', '($group)');
    });

    // Convert pattern to a full regex
    // pattern = ':type/:name' -> '(fix|docs|...)/(a-z0-9-+)'
    final regex = RegExp('^$pattern\$');

    if (!regex.hasMatch(branchName)) {
      throw branchNamePatternError;
    }

    return true;
  }

  /// Retrieves the current branch name
  static Future<String> get currentBranchName async {
    final result =
        await Process.run('git', ['rev-parse', '--abbrev-ref', 'HEAD']);
    if (result.exitCode != 0) {
      throw Exception('Failed to get branch name: ${result.stderr}');
    }
    return (result.stdout as String).trim();
  }

  static Future<BranchName> current(Config config) async {
    return BranchName._(config, await currentBranchName);
  }
}
