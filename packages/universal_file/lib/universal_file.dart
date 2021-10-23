library universal_file;

// ignore: invalid_export_of_internal_element
export 'src/io_impl_vm.dart'
    if (dart.library.io) 'src/io_impl_vm.dart'
    if (dart.library.js) 'src/io_impl_js.dart'
    if (dart.library.html) 'src/io_impl_js.dart';
