import 'package:branch_name_lint/branch_name_lint.dart';
import 'package:test/test.dart';

void main() {
  group('BranchName Configuration Tests', () {
    group('Pattern matching', () {
      test('should accept valid branch name matching pattern', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature', 'fix', 'hotfix'],
            'name': ['[a-z0-9-]+'],
          },
        );

        final branchName =
            await BranchName.create(config, branchName: 'feature/my-feature');
        expect(() => branchName.lint(), returnsNormally);
      });

      test('should reject invalid branch name not matching pattern', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature', 'fix', 'hotfix'],
            'name': ['[a-z0-9-]+'],
          },
        );

        final branchName =
            await BranchName.create(config, branchName: 'invalid/MY-FEATURE');
        expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
      });

      test('should reject branch name with wrong type', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature', 'fix', 'hotfix'],
            'name': ['[a-z0-9-]+'],
          },
        );

        final branchName =
            await BranchName.create(config, branchName: 'wrong/my-feature');
        expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
      });

      test('should skip validation when pattern is empty', () async {
        final config = Config(
          pattern: '',
          params: {},
        );

        final branchName =
            await BranchName.create(config, branchName: 'any-branch-name');
        expect(() => branchName.lint(), returnsNormally);
      });
    });

    group('Params validation', () {
      test('should validate multiple param types', () async {
        final config = Config(
          pattern: ':type/:task/:description',
          params: {
            'type': ['feature', 'fix'],
            'task': ['[0-9]+'],
            'description': ['[a-z0-9-]+'],
          },
        );

        final branchName = await BranchName.create(
          config,
          branchName: 'feature/123/my-feature',
        );
        expect(() => branchName.lint(), returnsNormally);
      });

      test('should reject invalid task number format', () async {
        final config = Config(
          pattern: ':type/:task/:description',
          params: {
            'type': ['feature', 'fix'],
            'task': ['[0-9]+'],
            'description': ['[a-z0-9-]+'],
          },
        );

        final branchName = await BranchName.create(
          config,
          branchName: 'feature/abc/my-feature',
        );
        expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
      });

      test('should accept custom regex patterns', () async {
        final config = Config(
          pattern: ':username.:type/:issue',
          params: {
            'username': ['[a-z]+'],
            'type': ['feature', 'fix'],
            'issue': ['lbn-[a-z0-9-]+'],
          },
        );

        final branchName = await BranchName.create(
          config,
          branchName: 'john.feature/lbn-123-test',
        );
        expect(() => branchName.lint(), returnsNormally);
      });
    });

    group('Allowed list (whitelist)', () {
      test('should always allow whitelisted branches', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature'],
            'name': ['[a-z0-9-]+'],
          },
          allowed: ['main', 'development'],
        );

        final branchName = await BranchName.create(config, branchName: 'main');
        expect(() => branchName.lint(), returnsNormally);
      });

      test('should allow branch even if it would fail pattern', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature'],
            'name': ['[a-z0-9-]+'],
          },
          allowed: ['ci', 'test'],
        );

        final branchName = await BranchName.create(config, branchName: 'ci');
        expect(() => branchName.lint(), returnsNormally);
      });

      test('should allow branch even if it is in prohibited list', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature'],
            'name': ['[a-z0-9-]+'],
          },
          allowed: ['main'],
          prohibited: ['main'],
        );

        final branchName = await BranchName.create(config, branchName: 'main');
        expect(() => branchName.lint(), returnsNormally);
      });
    });

    group('Prohibited list (blacklist)', () {
      test('should reject prohibited branches', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature'],
            'name': ['[a-z0-9-]+'],
          },
          prohibited: ['main', 'master', 'ci', 'test'],
        );

        final branchName = await BranchName.create(config, branchName: 'main');
        expect(
          () => branchName.lint(),
          throwsA(
            predicate(
              (e) => e is BranchLintError && e == branchProtectedError,
            ),
          ),
        );
      });

      test('should reject all prohibited branches', () async {
        final config = Config(
          pattern: '',
          params: {},
          prohibited: ['main', 'master', 'build', 'test', 'wip', 'ci'],
        );

        for (final prohibited in config.prohibited) {
          final branchName =
              await BranchName.create(config, branchName: prohibited);
          expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
        }
      });
    });

    group('Priority: allowed > prohibited > pattern', () {
      test('allowed takes precedence over prohibited', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature'],
            'name': ['[a-z0-9-]+'],
          },
          allowed: ['main'],
          prohibited: ['main'],
        );

        final branchName = await BranchName.create(config, branchName: 'main');
        expect(() => branchName.lint(), returnsNormally);
      });

      test('prohibited takes precedence over pattern match', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature', 'test'],
            'name': ['[a-z0-9-]+'],
          },
          prohibited: ['test/branch'],
        );

        final branchName =
            await BranchName.create(config, branchName: 'test/branch');
        expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
      });

      test('pattern validation happens after prohibited check', () async {
        final config = Config(
          pattern: ':type/:name',
          params: {
            'type': ['feature'],
            'name': ['[a-z0-9-]+'],
          },
          prohibited: ['invalid'],
        );

        // This branch is both prohibited AND doesn't match pattern
        final branchName =
            await BranchName.create(config, branchName: 'invalid');
        expect(
          () => branchName.lint(),
          throwsA(
            predicate(
              (e) => e is BranchLintError && e == branchProtectedError,
            ),
          ),
        );
      });
    });
  });

  group('BranchName.create() CLI Arguments Tests', () {
    test('should use provided branch name when argument is given', () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
      );

      final branchName =
          await BranchName.create(config, branchName: 'feature/test-branch');
      expect(branchName.branchName, equals('feature/test-branch'));
      expect(() => branchName.lint(), returnsNormally);
    });

    test('should use provided branch name even if it fails validation',
        () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
      );

      final branchName =
          await BranchName.create(config, branchName: 'invalid/BRANCH');
      expect(branchName.branchName, equals('invalid/BRANCH'));
      expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
    });

    test('should handle empty string by falling back to git', () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
      );

      // Empty string should trigger git branch retrieval
      final branchName = await BranchName.create(config, branchName: '');
      expect(branchName.branchName, isNotEmpty);
    });

    test('should use git when branchName argument is null', () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
      );

      final branchName = await BranchName.create(config);
      expect(branchName.branchName, isNotEmpty);
    });

    test('should validate prohibited branch from argument', () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
        prohibited: ['main', 'master'],
      );

      final branchName = await BranchName.create(config, branchName: 'main');
      expect(() => branchName.lint(), throwsA(isA<BranchLintError>()));
    });

    test('should validate allowed branch from argument', () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
        allowed: ['development'],
      );

      final branchName =
          await BranchName.create(config, branchName: 'development');
      expect(() => branchName.lint(), returnsNormally);
    });
  });

  group('Integration Tests', () {
    test('full flow: CI/CD scenario with custom branch name', () async {
      // Simulate CI/CD environment variable
      const ciBranchName = 'feature/ci-123-integration';

      final config = Config(
        pattern: ':type/:task-:description',
        params: {
          'type': ['feature', 'fix', 'hotfix'],
          'task': ['[a-z]+-[0-9]+'],
          'description': ['[a-z0-9-]+'],
        },
        prohibited: ['main', 'master'],
      );

      final branchName =
          await BranchName.create(config, branchName: ciBranchName);
      expect(() => branchName.lint(), returnsNormally);
    });

    test('monorepo with scopes scenario', () async {
      final config = Config(
        pattern: ':type/:scope/:description',
        params: {
          'type': ['feature', 'fix'],
          'scope': ['app', 'shared', 'api'],
          'description': ['[a-z0-9-]+'],
        },
      );

      final branchName =
          await BranchName.create(config, branchName: 'feature/app/new-ui');
      expect(() => branchName.lint(), returnsNormally);
    });

    test('only prohibited branches check (no pattern)', () async {
      final config = Config(
        pattern: '',
        params: {},
        prohibited: ['main', 'master', 'build', 'test', 'wip', 'ci', 'release'],
      );

      // Should pass for any non-prohibited branch
      final validBranch =
          await BranchName.create(config, branchName: 'my-feature-branch');
      expect(() => validBranch.lint(), returnsNormally);

      // Should fail for prohibited branch
      final prohibitedBranch =
          await BranchName.create(config, branchName: 'main');
      expect(() => prohibitedBranch.lint(), throwsA(isA<BranchLintError>()));
    });

    test('complex pattern with username and issue', () async {
      final config = Config(
        pattern: ':username.:type/:issue',
        params: {
          'username': ['[a-z]+'],
          'type': ['feature', 'fix', 'misc', 'docs'],
          'issue': ['lbn-[a-z0-9-]+'],
        },
        prohibited: ['main'],
      );

      final branchName = await BranchName.create(
        config,
        branchName: 'john.feature/lbn-123-awesome',
      );
      expect(() => branchName.lint(), returnsNormally);
    });
  });

  group('Deprecated current() method', () {
    test('current() should still work for backward compatibility', () async {
      final config = Config(
        pattern: ':type/:name',
        params: {
          'type': ['feature'],
          'name': ['[a-z0-9-]+'],
        },
      );

      // ignore: deprecated_member_use_from_same_package
      final branchName = await BranchName.current(config);
      expect(branchName.branchName, isNotEmpty);
    });
  });
}
