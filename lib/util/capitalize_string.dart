String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;
  }

  final firstLetter = input[0].toUpperCase();
  final restOfString = input.substring(1);

  return '$firstLetter$restOfString';
}
