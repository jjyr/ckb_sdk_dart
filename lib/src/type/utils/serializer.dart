import 'dart:core';

import 'package:ckb_sdk_dart/ckb_type.dart';
import 'package:ckb_sdk_dart/src/rpc/convert.dart';
import 'package:ckb_sdk_dart/src/serialization/base/fixed_type.dart';
import 'package:ckb_sdk_dart/src/serialization/base/serialize_type.dart';
import 'package:ckb_sdk_dart/src/serialization/dynamic/bytes.dart';
import 'package:ckb_sdk_dart/src/serialization/dynamic/dynamic.dart';
import 'package:ckb_sdk_dart/src/serialization/dynamic/table.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/byte1.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/byte32.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/empty.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/fixed.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/struct.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/uint32.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/uint64.dart';

class Serializer {
  static Struct serializeOutPoint(OutPoint outPoint) {
    Byte32 txHash = Byte32.fromHex(outPoint.txHash);
    Uint32 index = Uint32.fromHex(outPoint.index);
    return Struct(<FixedType>[txHash, index]);
  }

  static Table serializeScript(Script script) {
    return Table([
      Byte32.fromHex(script.codeHash),
      Byte1.fromHex(Script.data == script.hashType ? "00" : "01"),
      Dynamic(script.args.map((arg) => Bytes.fromHex(arg)).toList())
    ]);
  }

  static Struct serializeCellInput(CellInput cellInput) {
    Uint64 sinceUInt64 = Uint64.fromHex(cellInput.since);
    Struct outPointStruct = serializeOutPoint(cellInput.previousOutput);
    return Struct(<SerializeType>[sinceUInt64, outPointStruct]);
  }

  static Table serializeCellOutput(CellOutput cellOutput) {
    return Table([
      Uint64.fromHex(cellOutput.capacity),
      serializeScript(cellOutput.lock),
      cellOutput.type != null ? serializeScript(cellOutput.type) : Empty()
    ]);
  }

  static Struct serializeCellDep(CellDep cellDep) {
    Struct outPointStruct = serializeOutPoint(cellDep.outPoint);
    Byte1 depTypeBytes = CellDep.code == cellDep.depType
        ? Byte1.fromHex("0")
        : Byte1.fromHex("1");
    return Struct([outPointStruct, depTypeBytes]);
  }

  static Fixed<Struct> serializeCellDeps(List<CellDep> cellDeps) {
    return Fixed(cellDeps.map((cellDep) => serializeCellDep(cellDep)).toList());
  }

  static Fixed<Struct> serializeCellInputs(List<CellInput> cellInputs) {
    return Fixed(
        cellInputs.map((cellInput) => serializeCellInput(cellInput)).toList());
  }

  static Dynamic<Table> serializeCellOutputs(List<CellOutput> cellOutputs) {
    return Dynamic(cellOutputs
        .map((cellOutput) => serializeCellOutput(cellOutput))
        .toList());
  }

  static Dynamic<Bytes> serializeBytes(List<String> bytes) {
    return Dynamic(bytes.map((byte) => Bytes.fromHex(byte)).toList());
  }

  static Fixed<Byte32> serializeByte32(List<String> bytes) {
    return Fixed(bytes.map((byte) => Byte32.fromHex(byte)).toList());
  }

  static Table serializeTransaction(Transaction transaction) {
    Transaction tx = Convert.parseTransaction(transaction);
    return Table([
      Uint32.fromHex(tx.version),
      Serializer.serializeCellDeps(tx.cellDeps),
      Serializer.serializeByte32(tx.headerDeps),
      Serializer.serializeCellInputs(tx.inputs),
      Serializer.serializeCellOutputs(tx.outputs),
      Serializer.serializeBytes(tx.outputsData)
    ]);
  }
}