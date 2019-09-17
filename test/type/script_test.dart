import 'package:ckb_sdk_dart/ckb_type.dart';
import 'package:ckb_sdk_dart/src/crypto/blake2b.dart';
import 'package:ckb_sdk_dart/src/rpc/api.dart';
import 'package:ckb_sdk_dart/src/utils/utils.dart';
import 'package:test/test.dart';

@Skip('Skip rpc test')
void main() {
  group('A group tests of Script', () {
    setUp(() {});

    test('Script hash', () async {
      Blake2b blake2b = Blake2b();
      blake2b.updateWithHex(
          '0x1400000000000e00100000000c000800000004000e0000000c00000014000000740100000000000000000600080004000600000004000000580100007f454c460201010000000000000000000200f3000100000078000100000000004000000000000000980000000000000005000000400038000100400003000200010000000500000000000000000000000000010000000000000001000000000082000000000000008200000000000000001000000000000001459308d00573000000002e7368737472746162002e74657874000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000010000000600000000000000780001000000000078000000000000000a000000000000000000000000000000020000000000000000000000000000000100000003000000000000000000000000000000000000008200000000000000110000000000000000000000000000000100000000000000000000000000000000000000');
      String codeHash = appendHexPrefix(blake2b.doFinalString());
      Script script =
          Script(codeHash: codeHash, args: [], hashType: Script.data);
      Api api = Api('http://localhost:8114');
      String scriptHash = await api.computeScriptHash(script);
      expect(script.computeHash(), scriptHash);
    });
  });
}
