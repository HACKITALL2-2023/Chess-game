import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nova_chess/custom_widgets/check_box.dart';
import 'package:nova_chess/custom_widgets/custom_button_blue.dart';
import 'package:nova_chess/custom_widgets/custom_text_field.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';
import 'package:nova_chess/custom_widgets/error_container.dart';
import 'package:nova_chess/custom_widgets/logo_and_motto.dart';
import 'package:nova_chess/custom_widgets/password_text_field.dart';
import 'package:nova_chess/helper/navigation.dart';
import 'package:nova_chess/home_tournaments.dart';
import 'package:nova_chess/home.dart';
import 'package:nova_chess/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_widgets/background_widget.dart';
import 'helper/routes.dart';

class SignIn extends StatefulWidget{
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn>{
  final TextEditingController _usernameFieldController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();
  bool _saveCredentials = false;
  bool _showPassword = false;
  bool _wrongCredentials = false;

  String _username = '';
  String _password = '';
  Color getColor(Set<MaterialState> states) => const Color(0xFFFFFFFF);

  void _setShowPassword(){
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _setUsername(context){
    setState(() => _username = _usernameFieldController.text);
    FocusScope.of(context).unfocus();
  }

  void _setPassword(context){
    setState(() => _password = _passwordFieldController.text);
    FocusScope.of(context).unfocus();
  }

  void _setUsernameAndPassword(context){
    setState(() {
      _username = _usernameFieldController.text;
      _password = _passwordFieldController.text;
    });
    FocusScope.of(context).unfocus();
  }

  void _setSaveCredentials(){
    setState(() {
      _saveCredentials = !_saveCredentials;
    });
  }

  void _navigateSignUp () {
    Navigator.of(context).pushNamed(OwnRouter.signUpRoute);
  }

  Future<void> _checkSignIn() async{
    _username = _usernameFieldController.text;
    _password = _passwordFieldController.text;

    try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _username,
          password: _password
        );

        final prefs = await SharedPreferences.getInstance();
        if (_saveCredentials){
          setState(() {
            _wrongCredentials = false;
          });
          await prefs.setString('password', _password);
        }
        await prefs.setBool('save_credentials', _saveCredentials);
        await prefs.setString('username', _username);

        if (!mounted) return;
        await Navigator.of(context).pushNamedAndRemoveUntil(
          OwnRouter.homeRoute,
          (route) {
            return false;
          }
        );
        

      } on FirebaseAuthException catch (e) {
        setState(() {
            _wrongCredentials = true;
          });
      }
  }

  void _navigateForgotPassword(){
    print('navigated to forgot password');
  }

  void _customInit() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveCredentials = prefs.getBool('save_credentials') ?? false;  
    });
    _username = prefs.getString('username') ?? '';
    _password = prefs.getString('password') ?? '';
    _usernameFieldController.text = _username;
    _passwordFieldController.text = _password;
  }

  @override
  void initState() {
    _customInit();
    super.initState();
  }

  @override
  void dispose(){
    _usernameFieldController.dispose();
    _passwordFieldController.dispose();
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
          onTap: () => _setUsernameAndPassword(context),
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
                      onEditingComplete: _setUsername,
                      errorBorder: false,
                      hintText: 'Your email',
                      onTap: () => setState(() {
                        _wrongCredentials = false;
                      }),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  PasswordTextField(
                    context: context,
                    width: width,
                    height: height,
                    textEditingController: _passwordFieldController,
                    onEditingComplete: _setPassword,
                    showPassword: _setShowPassword,
                    errorBorder: false,
                    showPasswordBool: _showPassword,
                    hintText: 'Your Password',
                    onTap: () => setState(() {
                      _wrongCredentials = false;
                    }),
                  ),
                  Container(
                    width: width * 0.78,
                    margin: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              CustomCheckBox(
                                setValue: _setSaveCredentials,
                                checked: _saveCredentials
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: const CustomTextWidgetWhite(
                                  text: 'Remember me',
                                  textSize: 13
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent)
                                  ),
                                  onPressed: _navigateForgotPassword,
                                  child: const CustomTextWidgetWhite(
                                    text: 'Forgot password?',
                                    textSize: 13,
                                  ),
                                ),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  ErrorContainer(
                    width: width,
                    height: height,
                    mainAxisAlignment: MainAxisAlignment.center,
                    shouldAppear: _wrongCredentials,
                    text: 'The username or password you entered is incorrect.',
                    textSize: 11,
                  ),
                  CustomButtonBlue(
                    width: width * 0.46,
                    height: height * 0.06,
                    text: 'Sign In',
                    textSize: 24,
                    onPressed: _checkSignIn,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidgetWhite(
                        text: 'Don\'t have an account?',
                        textSize: 15,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent)
                        ),
                        onPressed: _navigateSignUp,
                        child: const CustomTextWidgetBlue(
                          text: 'Sign Up',
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
        )
        ),
      )
    );
  }
}
