String frequencyFormat(String frequency) {
  if (frequency == 'null') frequency = '0000000000';
  frequency = frequency.padLeft(10, '0');
  String formatFrequency = frequency;
  var len = frequency.length;
  String first = '';
  String second = '';
  String third = '';
  if (len > 0) {
    third = frequency.substring(len - 3, len - 1);
  }
  if (len > 2) {
    second = frequency.substring(len - 6, len - 3);
  }
  if (len > 6) {
    first = frequency.substring(0, len - 6);
  }
  formatFrequency = first + '.' + second + '.' + third;
  return formatFrequency;
}
