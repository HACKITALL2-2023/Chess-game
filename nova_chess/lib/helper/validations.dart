class HelperValidations{
  static bool emailValid(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  }

  static bool usernameValid(String username){
    return (username.contains(' ')) ? false : true;
  }

  static List<PasswordWrongMatches> passwordValid(String password){
    List<PasswordWrongMatches> foundMissmatches = [];

    if (password.length < 8){
      foundMissmatches.add(PasswordWrongMatches.notEnoughCh);
    }

    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)){
      foundMissmatches.add(PasswordWrongMatches.upperCase);
    }

    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)){
      foundMissmatches.add(PasswordWrongMatches.lowerCase);
    }

    if (!RegExp(r'(?=.*[0-9])').hasMatch(password)){
      foundMissmatches.add(PasswordWrongMatches.digit);
    }

    if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password)){
      foundMissmatches.add(PasswordWrongMatches.specialCh);
    }

    return foundMissmatches;
  }
}

enum PasswordWrongMatches{
  notEnoughCh,
  upperCase,
  lowerCase,
  digit,
  specialCh
}