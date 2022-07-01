
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "enter an email";
  } else if (value.length > 5 &&
      value.contains('@') &&
      value.endsWith('.com')) {
    return null;
  } else {
    return "enter a valid email";
  }
}