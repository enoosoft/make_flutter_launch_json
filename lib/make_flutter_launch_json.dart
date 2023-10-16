import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_pretty/json_pretty.dart';
import 'package:process_run/which.dart';

var jsonFilePath = '.vscode/launch.g.json';

Future<void> make() async {
  await writeLaunchJson(await makeLaunchJsonString());
  print('Done. Wrote $jsonFilePath');
}

Future<String> makeLaunchJsonString() async {
  print('Making launch.json...');
  final devices = await getDevices();

  var json = <String, dynamic>{};
  json['version'] = '0.2.0';
  json['configurations'] = devicesToMap(devices, json);
  final launchJson = prettyPrintJson(jsonEncode(json));
  print('launchJson: $launchJson');
  return launchJson;
}

List<Map> devicesToMap(String devices, Map<String, dynamic> json) {
  List<Map> list = [];
  final lines = devices.split('\n');
  for (var line in lines) {
    if (line.contains('•')) {
      final parts = line.split('•');
      final name = parts[0].trim();
      final request = 'launch';
      final type = 'dart';
      final deviceId = parts[1].trim();
      final flutterMode = 'debug';
      list.add({
        'name': name,
        'request': request,
        'type': type,
        'deviceId': deviceId,
        'flutterMode': flutterMode,
      });
    }
  }
  return list;
}

Future<File> get _launchJsonFile async {
  final file = File(jsonFilePath);
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  return file;
}

Future<File> writeLaunchJson(String json) async {
  final file = await _launchJsonFile;
  return file.writeAsString(json);
}

Future<String> getDevices() async {
  print('Getting devices...');
  var flutterExectutable = whichSync('flutter');
  print('flutterExectutable: $flutterExectutable');
  if (flutterExectutable == null) {
    print('flutterExectutable is null');
    return '';
  }
  var processResult =
      await Process.run(flutterExectutable, ['devices'], stdoutEncoding: utf8);
  String devices = await processResult.stdout;
  print('devices: $devices');
  return devices;
}
