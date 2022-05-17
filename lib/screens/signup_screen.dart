import 'package:news_app/logic/auth/authentication.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/utils/dialogs.dart';
import 'package:news_app/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailCtrl = TextEditingController(),
      nameCtrl = TextEditingController(),
      passwordCtrl = TextEditingController(),
      confirmPasswordCtrl = TextEditingController();
  bool isVisible = true;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
        ),
        body: Container(
          height: h,
          width: w,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InputField(
                    trailingIcon: IconButton(
                      icon: const Icon(
                        Icons.person_outline,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {},
                    ),
                    controller: nameCtrl,
                    inputType: TextInputType.name,
                    labelText: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  InputField(
                    trailingIcon: IconButton(
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {},
                    ),
                    controller: emailCtrl,
                    inputType: TextInputType.emailAddress,
                    labelText: 'Email Address',
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!))
                        return 'Please Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  InputField(
                    trailingIcon: IconButton(
                      icon: Icon(
                        isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    ),
                    isVisible: isVisible,
                    controller: passwordCtrl,
                    inputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Please Enter a valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  InputField(
                    trailingIcon: IconButton(
                      icon: Icon(
                        isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    ),
                    isVisible: isVisible,
                    controller: confirmPasswordCtrl,
                    inputType: TextInputType.visiblePassword,
                    labelText: 'Confirm Password',
                    validator: (value) {
                      if (value!.isEmpty || passwordCtrl.text != value) {
                        return 'Passwords don\'t match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Button(
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        showLoaderDialog(context);
                        final user = await Authentication.signUp(
                          name: nameCtrl.text.trim(),
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                        );
                        if (user == null) {
                          Navigator.pop(context);
                          showErrorDialog(context,
                              'Some error occurred.\nPlease try again later');
                          return;
                        }
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      }
                    },
                    text: 'Sign Up',
                    width: w,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account ? ',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: const TextStyle(
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
