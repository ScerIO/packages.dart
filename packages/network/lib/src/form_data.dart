import 'package:http/http.dart';

class FormData {
  FormData.from({this.fields = const {}, this.files = const []})
      : assert(fields != null),
        assert(files != null);

  final Map<String, String> fields;
  final List<MultipartFile> files;
}
