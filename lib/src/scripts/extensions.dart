//  Copyright 2020 Bruno D'Luka

extension Str on List<dynamic> {
  List<String> toStringList() {
    final l = <String>[];
    for (var i in this) {
      l.add(i.toString());
    }
    return l;
  }
}
