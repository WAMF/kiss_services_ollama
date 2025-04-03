import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';
import 'dart:io';
import 'package:yaml/yaml.dart';

@CloudFunction()
Response function(Request request) {
  final pubspecFile = File('pubspec.yaml');
  final pubspecContent = pubspecFile.readAsStringSync();
  final pubspecYaml = loadYaml(pubspecContent);
  final version = pubspecYaml['version'] ?? 'unknown';
  return Response.ok('Version: $version');
}
