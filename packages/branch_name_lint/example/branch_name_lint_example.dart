import 'package:branch_name_lint/branch_name_lint.dart';

final config = Config.create((dirsReader) => {
      'pattern': ':username:type/:desc/:issue',
      'params': {
        'type': [
          'feature',
          'fix',
          'misc',
          'docs',
        ],
        'username': ['[a-z-]+'],
        'desc': ['[a-z-]+'],
        'issue': ['lbn-[a-z0-9-]+'],
      },
      'allowed': ['test'],
      'prohibited': [
        'master',
        'main',
        'build',
        'wip',
        'ci',
        'release',
      ],
    });

void main() {
  print(config);
}
