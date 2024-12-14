import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

typedef BranchNameOptions = Map<String, Object?>;
typedef DirectoriesReader = List<String> Function(String path);

/// Default configuration
final _defaultConfig = Config(
  pattern: ':type/:name',
  params: {
    'type': ['fix', 'docs', 'misc', 'feature', 'hotfix'],
    'name': ['[a-z0-9-]+'],
  },
  prohibited: [
    'ci',
    'wip',
    'main',
    'master',
    'test',
    'build',
    'release',
  ],
);

/// Branch name linter's configuration
class Config {
  final String pattern;
  final Map<String, List<String>> params;
  final List<String> prohibited;
  final List<String> allowed;

  const Config({
    required this.pattern,
    required this.params,
    this.prohibited = const [],
    this.allowed = const [],
  });

  factory Config.fromJson(Map<String, Object?> json) {
    final params = Map<String, Object>.from(json['params'] as Map);

    final paramsTransformed = params.entries.map((entry) => MapEntry(
          entry.key,
          entry.value is List
              ? (entry.value as List).map((e) => e.toString()).toList()
              : [entry.value.toString()],
        ));

    return Config(
      pattern: json['pattern'] as String? ?? ':type/:name',
      params: Map<String, List<String>>.fromEntries(paramsTransformed),
      prohibited:
          (json['prohibited'] as List? ?? []).map((e) => e.toString()).toList(),
      allowed:
          (json['allowed'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }

  static Future<Map<String, Object?>> _decodeFile(File file) async {
    final content = await file.readAsString();
    final jsonData = loadYaml(content);
    return Map<String, Object?>.from(jsonDecode(jsonEncode(jsonData)));
  }

  /// Return branch lint actual project's configuration
  static Future<Config> find(String moduleName) async {
    final pubspecData = await _decodeFile(File('./pubspec.yaml'));

    if (pubspecData['branch_name_lint'] != null) {
      return Config.fromJson(
          pubspecData['branch_name_lint'] as BranchNameOptions);
    }

    final candidates = [
      '.$moduleName',
      moduleName,
      '$moduleName.yaml',
      '.$moduleName.yaml',
      '$moduleName.yml',
      '.$moduleName.yml',
    ];

    for (final candidate in candidates) {
      final file = File(candidate);
      if (await file.exists()) {
        final jsonMap = await _decodeFile(file);

        return Config.fromJson(jsonMap);
      }
    }

    return _defaultConfig;
  }

  static Config create(
          BranchNameOptions Function(DirectoriesReader readDirectories) data) =>
      Config.fromJson(data(readDirectories));

  static List<String> readDirectories(String path) => Directory(path)
      .listSync()
      .whereType<Directory>()
      .map((dir) => dir.path
          .split(Platform.pathSeparator)
          .last) // Извлекаем имя директории
      .toList();
}
