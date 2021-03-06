class TransactionPoint {
  String blockNumber;
  String txHash;
  String index;

  TransactionPoint({this.blockNumber, this.txHash, this.index});

  factory TransactionPoint.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return TransactionPoint(
        blockNumber: json['block_number'],
        txHash: json['tx_hash'],
        index: json['index']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'block_number': blockNumber,
      'tx_hash': txHash,
      'index': index
    };
  }
}
