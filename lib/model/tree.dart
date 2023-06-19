
class Tree {
  int treeIdx;
  int position;

  Tree({
    required this.treeIdx,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'treeIdx': this.treeIdx,
      'position': this.position,
    };
  }

  factory Tree.fromMap(Map<String, dynamic> map) {
    return Tree(
      treeIdx: map['treeIdx'] as int,
      position: map['position'] as int,
    );
  }
}
