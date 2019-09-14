class OutPoint {
  String txHash;
  String index;

  OutPoint({this.txHash, this.index});

  factory OutPoint.fromJson(Map<String, dynamic> json) {
    return OutPoint(txHash: json['tx_hash'], index: json['index']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx_hash': txHash,
      'index': index,
    };
  }
}
