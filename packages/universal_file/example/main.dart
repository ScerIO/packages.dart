import 'package:universal_file/universal_file.dart';

// And usage anywhere with backward capability!
main() async {
  final object = 'file';

  try {
    final file = File('$object.txt');
    if (await file.exists()) {
      final modified = await file.lastModified();
      print('File for $object already exists. It was modified on $modified.');
    }
    await file.create();
    await file.writeAsString('Start describing $object in this file.');
    final description = await file.readAsString();
    print(description);
  } on IOException catch (e) {
    print('Cannot create description for $object: $e');
  }
}
