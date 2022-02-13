class Validators {
  static String? mailValidator(String? value) {
    if (value != null || value!.isNotEmpty) {
      bool _check = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (_check) {
        return null;
      } else {
        return "It's not an email";
      }
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return 'Must not be empty. Must be 10 digits';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Empty field';
    } else if (value != null && value.length < 6) {
      return 'Must be greated than 6';
    } else {
      return null;
    }
  }
}
