import 'dart:io';

import 'package:make_flutter_launch_json/make_flutter_launch_json.dart';
import 'package:test/test.dart';

void main() {
  test('make', () async {
    await make();

    final file = File('.vscode/launch.g.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      print('contents: $contents');
      expect(contents, isNotEmpty);
    }
  });
}
