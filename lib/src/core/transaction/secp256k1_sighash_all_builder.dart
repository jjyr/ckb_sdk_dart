import 'dart:typed_data';

import 'package:ckb_sdk_dart/ckb_crypto.dart';
import 'package:ckb_sdk_dart/src/core/transaction/script_group.dart';
import 'package:ckb_sdk_dart/src/core/type/transaction.dart';
import 'package:ckb_sdk_dart/src/core/type/utils/serializer.dart';
import 'package:ckb_sdk_dart/src/core/type/witness.dart';
import 'package:ckb_sdk_dart/src/crypto/sign.dart';
import 'package:ckb_sdk_dart/src/serialization/fixed/uint64.dart';
import 'package:ckb_sdk_dart/src/utils/utils.dart';

class Secp256k1SighashAllBuilder {
  Transaction _transaction;

  Secp256k1SighashAllBuilder(Transaction transaction) {
    _transaction = transaction;
  }

  void sign(ScriptGroup scriptGroup, String privateKey) {
    var groupWitnesses = [];
    if (_transaction.witnesses.length < _transaction.inputs.length) {
      throw Exception(
          'Transaction witnesses count must not be smaller than inputs count');
    }
    if (scriptGroup.inputIndexes.isEmpty) {
      throw Exception('Need at least one witness!');
    }
    scriptGroup.inputIndexes
        .forEach((index) => groupWitnesses.add(_transaction.witnesses[index]));

    for (var i = _transaction.inputs.length;
        i < _transaction.witnesses.length;
        i++) {
      groupWitnesses.add(_transaction.witnesses[i]);
    }
    if (groupWitnesses[0] is! Witness) {
      throw Exception('First witness must be of Witness type!');
    }
    var txHash = _transaction.computeHash();
    Witness emptiedWitness = groupWitnesses[0];
    emptiedWitness.lock = Witness.SIGNATURE_PLACEHOLDER;
    var witnessTable = Serializer.serializeWitnessArgs(emptiedWitness);
    var blake2b = Blake2b();
    blake2b.update(hexToList(txHash));
    blake2b.update(UInt64.fromInt(witnessTable.getLength()).toBytes());
    blake2b.update(witnessTable.toBytes());
    for (var i = 1; i < groupWitnesses.length; i++) {
      Uint8List bytes;
      if (groupWitnesses[i] is Witness) {
        bytes = Serializer.serializeWitnessArgs(groupWitnesses[i]).toBytes();
      } else {
        bytes = hexToList(groupWitnesses[i]);
      }
      blake2b.update(UInt64.fromInt(bytes.length).toBytes());
      blake2b.update(bytes);
    }
    var message = blake2b.doFinalString();

    Witness signedWitness = groupWitnesses[0];
    signedWitness.lock = listToHex(
        Sign.signMessage(hexToList(message), privateKey).getSignature());

    _transaction.witnesses[scriptGroup.inputIndexes[0]] =
        listToHex(Serializer.serializeWitnessArgs(signedWitness).toBytes());
  }

  Transaction buildTx() {
    return _transaction;
  }
}
