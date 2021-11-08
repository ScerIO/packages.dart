import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';

void main() async {
  final storageIO = InternetFileStorageIO();

  await InternetFile.get(
    'https://github.com/rbcprolabs/icon_font_generator/raw/master/example/lib/icon_font/ui_icons.ttf',
    storage: storageIO,
    storageAdditional: {
      'filename': 'ui_icons.ttf',
      'location': '',
    },
    process: (percentage) {
      print('downloadPercentage: $percentage');
    },
  );
}
