import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';

void main() async {
  final storageIO = InternetFileStorageIO();

  await InternetFile.get(
    'http://www.africau.edu/images/default/sample.pdf',
    storage: storageIO,
    storageAdditional: storageIO.additional(
      filename: 'ui_icons.ttf',
      location: '',
    ),
    force: true,
    progress: (receivedLength, contentLength) {
      final percentage = receivedLength / contentLength * 100;
      print(
          'download progress: $receivedLength of $contentLength ($percentage%)');
    },
  );
}
