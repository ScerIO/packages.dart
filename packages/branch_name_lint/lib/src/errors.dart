import 'package:branch_name_lint/src/config.dart';

/// Colored output (ANSI escape codes)
String _redBrightBg(String msg) => '\x1B[41m\x1B[97m$msg\x1B[0m';
String _grayBold(String msg) => '\x1B[90m\x1B[1m$msg\x1B[0m';
String _white(String msg) => '\x1B[97m$msg\x1B[0m';
String _greenBright(String msg) => '\x1B[92m$msg\x1B[0m';

class BranchLintError extends Error {
  final String message;
  BranchLintError(this.message);

  @override
  String toString() => '[BranchNameLint] $message';
}

final branchProtectedError = BranchLintError('Protected branch');
final branchNamePatternError =
    BranchLintError('Branch name doesn\'t match the pattern');

/// Print error
void printError(String message) {
  print(_redBrightBg('\n$message\n'));
}

/// Print hints when errors occur
void printHint(BranchLintError error, Config config) {
  final pattern = config.pattern;
  final params = config.params;
  final prohibited = config.prohibited;

  if (error == branchProtectedError) {
    print(_white('Prohibited branch names:'));
    print(_greenBright('  ${prohibited.join(', ')}'));
  } else if (error == branchNamePatternError) {
    print(_grayBold('Branch name'));
    print('${_white('  pattern:')} ${_greenBright(pattern)}');
    if (params.isNotEmpty) {
      print(_grayBold('Name params'));
      params.forEach((key, value) {
        print('${_white('  $key:')} ${_greenBright(value.join(', '))}');
      });
    }
  }

  print('\n');
}
