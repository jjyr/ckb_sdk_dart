import 'dart:typed_data';

import '../../utils/utils.dart';
import '../base/fixed_type.dart';

class UInt64 extends FixedType<BigInt> {
  BigInt _value;

  UInt64(this._value);

  factory UInt64.fromInt(int value) {
    return UInt64(BigInt.from(value));
  }

  factory UInt64.fromHex(String hex) {
    try {
      return UInt64(BigInt.parse(cleanHexPrefix(hex), radix: 16));
    } catch (error) {
      return UInt64(BigInt.from(0));
    }
  }

  // generate int value from little endian bytes
  factory UInt64.fromBytes(Uint8List bytes) {
    var result = 0;
    for (var i = 7; i >= 0; i--) {
      result += (bytes[i] & 0xff) << 8 * i;
    }
    return UInt64.fromInt(result);
  }

  @override
  int getLength() {
    return 8;
  }

  @override
  BigInt getValue() {
    return _value;
  }

  @override
  Uint8List toBytes() {
    return Uint8List.fromList([]
      ..add(_value.toInt())
      ..add((_value >> 8).toInt())
      ..add((_value >> 16).toInt())
      ..add((_value >> 24).toInt())
      ..add((_value >> 32).toInt())
      ..add((_value >> 40).toInt())
      ..add((_value >> 48).toInt())
      ..add((_value >> 56).toInt()));
  }
}
