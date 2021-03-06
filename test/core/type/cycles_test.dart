import 'dart:convert';

import 'package:ckb_sdk_dart/src/core/type/cycles.dart';
import 'package:test/test.dart';

void main() {
  dynamic _json;
  group('A group tests of cycles', () {
    setUp(() {
      var cycles = '''{
        "cycles": "0xc"
      }''';
      _json = jsonDecode(cycles);
    });

    test('fromJson', () async {
      var cycles = Cycles.fromJson(_json);
      expect(cycles.cycles, '0xc');
    });

    test('toJson', () async {
      var cycles = Cycles.fromJson(_json);
      var map = cycles.toJson();
      expect(map['cycles'], '0xc');
    });
  });
}
