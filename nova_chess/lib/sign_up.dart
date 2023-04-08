import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:nova_chess/custom_widgets/check_box.dart';
import 'package:nova_chess/custom_widgets/custom_button_blue.dart';
import 'package:nova_chess/custom_widgets/custom_pop_up_dialog.dart';
import 'package:nova_chess/custom_widgets/custom_text_field.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';
import 'package:nova_chess/custom_widgets/error_container.dart';
import 'package:nova_chess/custom_widgets/logo_and_motto.dart';
import 'package:nova_chess/helper/helper.dart';
import 'package:nova_chess/helper/navigation.dart';
import 'package:nova_chess/helper/routes.dart';
import 'package:nova_chess/helper/validations.dart';
import 'package:nova_chess/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_widgets/password_text_field.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final TextEditingController _usernameFieldController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();
  final TextEditingController _confirmPasswordFieldController = TextEditingController();
  bool _showPassword = false;
  bool _agreeWithTermsAndConditions = false;
  bool _usernameValidity = true;
  bool _emailValidity = true;
  bool _passwordValidity = true;
  bool _confirmPasswordValidity = true;
  bool _allCredentialsValidity = false;
  bool _signUpError = false;
  String _signUpErrorText = '';
  List<PasswordWrongMatches> _passwordWrongMatches = [];

  String _passwordErrorMessage(){
    String passwordErrorMessageText = 'Your password needs to:';
    if (_passwordWrongMatches.contains(PasswordWrongMatches.lowerCase) || _passwordWrongMatches.contains(PasswordWrongMatches.lowerCase)){
      passwordErrorMessageText += '\n• include both lower and upper case characters';
    }

    if (_passwordWrongMatches.contains(PasswordWrongMatches.digit)){
      passwordErrorMessageText += '\n• include at least one number';
    }

    if (_passwordWrongMatches.contains(PasswordWrongMatches.specialCh)){
      passwordErrorMessageText += '\n• include at least one symbol';
    }

     if (_passwordWrongMatches.contains(PasswordWrongMatches.notEnoughCh)){
      passwordErrorMessageText += '\n• be at least 8 characters long';
    }

    return passwordErrorMessageText;
  }

  void _checkCredentials(){
    setState(() {
      _allCredentialsValidity = _usernameValidity && _passwordValidity && _confirmPasswordValidity && _emailValidity;
      _signUpError = false;
      _signUpErrorText = '';
    });
  }

  void _setShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _setTermsAndConditions() {
    setState(() {
      _agreeWithTermsAndConditions = !_agreeWithTermsAndConditions;
    });
  }

  void _checkUsernameValidity(){
    String username = _usernameFieldController.text;
    setState(() {
      _usernameValidity = (HelperValidations.usernameValid(username)) ? true : false;
      _checkCredentials();
    });
  }

  void _checkEmailValidity(){
    String email = _emailFieldController.text;
    setState(() {
      _emailValidity = (HelperValidations.emailValid(email)) ? true : false;
      _checkCredentials();
    });
  }

  void _checkPasswordValidity(){
    String confirmPassword = _confirmPasswordFieldController.text;
    String password = _passwordFieldController.text;
    setState(() {
      _passwordWrongMatches = HelperValidations.passwordValid(password);
      _passwordValidity = (_passwordWrongMatches.isEmpty) ? true : false;
      _confirmPasswordValidity = (confirmPassword == password) ? true : false;
      _checkCredentials();
    });
  }

  void _checkConfirmPasswordValidity(){
    String confirmPassword = _confirmPasswordFieldController.text;
    String password = _passwordFieldController.text;
    setState(() {
      _passwordWrongMatches = HelperValidations.passwordValid(password);
      _passwordValidity = (_passwordWrongMatches.isEmpty) ? true : false;
      _confirmPasswordValidity = (confirmPassword == password) ? true : false;
      _checkCredentials();
    });
  }

  Future<void> _navigateSignInScreen () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('save_credentials');
    await prefs.remove('password');
    await prefs.setString('username', _usernameFieldController.text);

    if (!mounted) return;
    await Navigator.of(context).pushNamedAndRemoveUntil(
      OwnRouter.signInRoute,
      (route){
        return false;
      }
    );
  }

  void _checkSignUp(double width){
    if (!_allCredentialsValidity){
      setState(() {
        _signUpError = true;
        _signUpErrorText = 'Bad credentials';
      });
    } else if (!_agreeWithTermsAndConditions){
      setState(() {
        _signUpError = true;
        _signUpErrorText = 'Please accept our terms and conditions';
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ConfirmEmailPopUpDialog(
          width: width,
          onPressed: _navigateSignInScreen,
        ),
      );
    }
  }

  void _showTermsAndConditionsDialog(width, height, context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TermsAndConditionsPopUp(
        width: width,
        height: height,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _usernameFieldController.addListener(_checkUsernameValidity);
    _emailFieldController.addListener(_checkEmailValidity);
    _passwordFieldController.addListener(_checkPasswordValidity);
    _confirmPasswordFieldController.addListener(_checkConfirmPasswordValidity);
  }

  @override
  void dispose(){
    _usernameFieldController.removeListener(_checkUsernameValidity);
    _emailFieldController.removeListener(_checkEmailValidity);
    _passwordFieldController.removeListener(_checkPasswordValidity);
    _confirmPasswordFieldController.removeListener(_checkConfirmPasswordValidity);

    _usernameFieldController.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _confirmPasswordFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BackgroundWidget(
        width: width,
        height: height,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Helper.giveUpFocus(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LoggoMottoWidget(
                  width: width,
                  height: height
                ),
                CustomTextField(
                  context: context,
                  width: width,
                  height: height,
                  textEditingController: _usernameFieldController,
                  onEditingComplete: Helper.giveUpFocus,
                  errorBorder: !_usernameValidity,
                  hintText: 'Your Username',
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
                  child: ErrorContainer(
                    width: width,
                    height: height,
                    mainAxisAlignment: MainAxisAlignment.start,
                    shouldAppear: !_usernameValidity,
                    text: 'Your Username should\'t have any space',
                    textSize: 11
                  ),
                ),
                CustomTextField(
                  context: context,
                  width: width,
                  height: height,
                  textEditingController: _emailFieldController,
                  onEditingComplete: Helper.giveUpFocus,
                  errorBorder: !_emailValidity,
                  hintText: 'Your Email Address',
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
                  child: ErrorContainer(
                    width: width,
                    height: height,
                    mainAxisAlignment: MainAxisAlignment.start,
                    shouldAppear: !_emailValidity,
                    text: 'Invalid email address',
                    textSize: 11
                  ),
                ),
                PasswordTextField(
                  context: context,
                  width: width,
                  height: height,
                  textEditingController: _passwordFieldController,
                  onEditingComplete: Helper.giveUpFocus,
                  showPassword: _setShowPassword,
                  errorBorder: !_passwordValidity,
                  showPasswordBool: _showPassword,
                  hintText: 'Your Password',
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(width * 0.05, (_passwordValidity) ? 0 : height * 0.02, 0, (_passwordValidity) ? 0 : height * 0.02),
                  child: ErrorContainerMultilines(
                    width: width,
                    height: height,
                    mainAxisAlignment: MainAxisAlignment.start,
                    shouldAppear: !_passwordValidity,
                    text: _passwordErrorMessage(),
                    textSize: 11,
                  ),
                ),
                PasswordTextField(
                  context: context,
                  width: width,
                  height: height,
                  textEditingController: _confirmPasswordFieldController,
                  onEditingComplete: Helper.giveUpFocus,
                  showPassword: _setShowPassword,
                  errorBorder: !_confirmPasswordValidity,
                  showPasswordBool: _showPassword,
                  hintText: 'Confirm Your Password',
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(width * 0.05, 0, 0, 0),
                  child: ErrorContainer(
                    width: width,
                    height: height,
                    mainAxisAlignment: MainAxisAlignment.start,
                    shouldAppear: !_confirmPasswordValidity,
                    text: 'The password confirmation does not match',
                    textSize: 11,
                  ),
                ),
                Container(
                  width: width * 0.78,
                  child: Row(
                    children: [
                      CustomCheckBox(
                        setValue: _setTermsAndConditions,
                        checked: _agreeWithTermsAndConditions
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const CustomTextWidgetWhite(
                        text: 'Agree with',
                        textSize: 13
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      TextButton(
                        child: const CustomTextWidgetBlue(
                          text: 'Terms & Conditions',
                          textSize: 13
                        ),
                        onPressed: () => _showTermsAndConditionsDialog(width, height, context)
                      ),
                    ],
                  ),
                ),
                ErrorContainer(
                  width: width,
                  height: height,
                  shouldAppear: _signUpError,
                  text: _signUpErrorText,
                  textSize: 11,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBlue(
                      width: width * 0.46,
                      height: height * 0.06,
                      text: 'Sign Up',
                      textSize: 24,
                      onPressed: () => _checkSignUp(width),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextWidgetWhite(
                      text: 'Already have an account?',
                      textSize: 15,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () =>  Navigator.pop(context),
                      child: const CustomTextWidgetBlue(
                        text: 'Sign In',
                        textSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}