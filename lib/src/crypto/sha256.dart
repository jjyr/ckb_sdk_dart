import 'dart:convert';
import 'dart:typed_data';

import 'package:ckb_sdk_dart/src/utils/utils.dart';
import 'package:pointycastle/export.dart';

class Sha256 {
  SHA256Digest _sha256digest;

  Sha256() {
    _sha256digest = SHA256Digest();
  }

  update(Uint8List input) {
    _sha256digest.update(input, 0, input.length);
  }

  updateString(String utf8String) {
    update(utf8.encode(cleanHexPrefix(utf8String)));
  }

  Uint8List doFinal() {
    var out = Uint8List(_sha256digest.digestSize);
    _sha256digest.doFinal(out, 0);
    return out;
  }

  String doFinalString() => listToHex(doFinal());

  static String hash(String input) {
    Sha256 sha256 = Sha256();
    sha256.updateString(input);
    return sha256.doFinalString();
  }
}