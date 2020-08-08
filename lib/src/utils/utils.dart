bool isNumber(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  if (n is num) {
    return true;
  } else {
    return false;
  }
}
