class LockHashIndexState {
  String blockHash;
  String blockNumber;
  String lockHash;

  LockHashIndexState({this.blockHash, this.blockNumber, this.lockHash});

  factory LockHashIndexState.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return LockHashIndexState(
        blockHash: json['block_hash'],
        blockNumber: json['block_number'],
        lockHash: json['lock_hash']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'block_hash': blockHash,
      'block_number': blockNumber,
      'lock_hash': lockHash,
    };
  }
}
