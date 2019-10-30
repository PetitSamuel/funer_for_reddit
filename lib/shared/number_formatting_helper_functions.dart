String fromIntToFormattedKString(int v) {
  String out = '';
  if (v >= 10000) {
    out = (v / 1000).toStringAsFixed(2) + 'k';
  }
  return out.isEmpty ? v.toString() : out;
}
