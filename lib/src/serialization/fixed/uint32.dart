import 'dart:typed_data';

import '../../utils/utils.dart';
import '../base/fixed_type.dart';

class UInt32 extends FixedType<int> {
  static final int byteSize = 4;

  int _value;

  UInt32(this._value);

  factory UInt32.fromHex(String hex) =>
      UInt32(BigInt.parse(cleanHexPrefix(hex), radix: 16).toInt());

  @override
  int getLength() {
    return byteSize;
  }

  @override
  int getValue() {
    return _value;
  }

  @override
  Uint8List toBytes() {
    return Uint8List.fromList(
        <int>[_value, _value >> 8, _value >> 16, _value >> 24]);
  }
}
