import 'dart:convert';

import 'package:ckb_sdk_dart/ckb_rpc.dart';
import 'package:test/test.dart';

void main() {
  dynamic _jsonResponse, _jsonError;
  group('A group tests of rpc', () {
    setUp(() {
      String response = '''{
        "id": 2,
        "jsonrpc": "2.0",
        "result": [
            {
                "block_hash": "0xc73a331428dd9ef69b8073c248bfae9dc7c27942bb1cb70581e880bd3020d7da",
                "block_number": "0x400",
                "lock_hash": "0xd8753dd87c7dd293d9b64d4ca20d77bb8e5f2d92bf08234b026e2d8b1b00e7e9"
            }
        ]
      }''';
      _jsonResponse = jsonDecode(response);

      String error = '''{
        "code": 2,
        "message": "rpc error"
      }''';
      _jsonError = jsonDecode(error);
    });

    test('respone fromJson', () async {
      RpcResponse response = RpcResponse.fromJson(_jsonResponse);
      expect(response.id, 2);
      expect(response.jsonrpc, '2.0');
    });

    test('respone toJson', () async {
      RpcResponse response = RpcResponse.fromJson(_jsonResponse);
      var map = response.toJson();
      expect(map['id'], 2);
      expect(map['jsonrpc'], '2.0');
    });

    test('error fromJson', () async {
      Error error = Error.fromJson(_jsonError);
      expect(error.code, 2);
      expect(error.message, 'rpc error');
    });

    test('error toJson', () async {
      Error error = Error.fromJson(_jsonError);
      var map = error.toJson();
      expect(map['code'], 2);
      expect(map['message'], 'rpc error');
    });
  });
}
