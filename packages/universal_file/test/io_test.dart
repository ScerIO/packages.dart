// Copyright 2020 terrier989@gmail.com.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library main_test;

import 'package:test/test.dart';
import 'package:universal_file/universal_file.dart';

part 'src/file.dart';

var serverPort = -1;
var secureServerPort = -1;

void main() {
  group('Chrome', () {
    _testFile();
  }, testOn: 'chrome');

  group('VM:', () {
    _testFile();
  }, testOn: 'vm');

  group('Node.JS', () {
    _testFile();
  }, testOn: 'node');
}
