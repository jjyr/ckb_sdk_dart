import 'dart:convert';

import 'package:ckb_sdk_dart/ckb_type.dart';
import 'package:test/test.dart';

void main() {
  dynamic _json;
  group('A group tests of cell with status', () {
    setUp(() {
      String cellWithStatus = '''{
          "cell": {
            "data": {
                "content": "0x7f454c460201010000000000000000000200f3000100000078000100000000004000000000000000980000000000000005000000400038000100400003000200010000000500000000000000000000000000010000000000000001000000000082000000000000008200000000000000001000000000000001459308d00573000000002e7368737472746162002e74657874000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000010000000600000000000000780001000000000078000000000000000a0000000000000000000000000000000200000000000000000000000000000001000000030000000000000000000000000000000000000082000000000000001100000000000000000000000000000001000000000000000000000000000000",
                "hash": "0x28e83a1277d48add8e72fadaa9248559e1b632bab2bd60b27955ebc4c03800a5"
            },
            "output": {
                "capacity": "0x802665800",
                "lock": {
                    "args": "0x",
                    "code_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
                    "hash_type": "data"
                },
                "type": null
            }
        },
        "status": "live"
      }''';
      _json = jsonDecode(cellWithStatus);
    });

    test('fromJson', () async {
      CellWithStatus cellWithStatus = CellWithStatus.fromJson(_json);
      expect(cellWithStatus.cell.data.content,
          '0x7f454c460201010000000000000000000200f3000100000078000100000000004000000000000000980000000000000005000000400038000100400003000200010000000500000000000000000000000000010000000000000001000000000082000000000000008200000000000000001000000000000001459308d00573000000002e7368737472746162002e74657874000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000010000000600000000000000780001000000000078000000000000000a0000000000000000000000000000000200000000000000000000000000000001000000030000000000000000000000000000000000000082000000000000001100000000000000000000000000000001000000000000000000000000000000');
      expect(cellWithStatus.cell.output.lock.codeHash,
          '0x0000000000000000000000000000000000000000000000000000000000000000');
    });

    test('toJson', () async {
      CellWithStatus cellWithStatus = CellWithStatus.fromJson(_json);
      var map = cellWithStatus.toJson();
      expect(map['cell']['data']['hash'],
          '0x28e83a1277d48add8e72fadaa9248559e1b632bab2bd60b27955ebc4c03800a5');
      expect(map['cell']['output']['capacity'], '0x802665800');
    });
  });
}
