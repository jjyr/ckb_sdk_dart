import 'dart:convert';

import 'package:ckb_sdk_dart/ckb_type.dart';
import 'package:test/test.dart';

void main() {
  dynamic _json;
  group('A group tests of epoch', () {
    setUp(() {
      String epoch = '''{
        "difficulty": "0x3e8",
        "length": "0x3e8",
        "number": "0x0",
        "start_number": "0x0"
      }''';
      _json = jsonDecode(epoch);
    });

    test('fromJson', () async {
      Epoch epoch = Epoch.fromJson(_json);
      expect(epoch.difficulty, '0x3e8');
      expect(epoch.startNumber, '0x0');
    });

    test('toJson', () async {
      Epoch epoch = Epoch.fromJson(_json);
      var map = epoch.toJson();
      expect(map['difficulty'], '0x3e8');
      expect(map['start_number'], '0x0');
    });
  });
}