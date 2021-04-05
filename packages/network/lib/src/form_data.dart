import 'package:http/http.dart';

class FormData {
  FormData.from({this.fields = const {}, this.files = const []});

  final Map<String, String> fields;
  final List<MultipartFile> files;
}
