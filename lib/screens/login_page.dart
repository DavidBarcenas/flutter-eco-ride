import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/resources/ride_colors.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:ecoride/screens/home_page.dart';
import 'package:ecoride/screens/register_page.dart';
import 'package:ecoride/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/logo.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void validateFields() {
    if (!emailController.text.contains('@')) {
      showSnackBar(Strings.emailError);
      return;
    }
    if (passwordController.text.length < 8) {
      showSnackBar(Strings.passwordLengthError);
      return;
    }
    login();
  }

  void login() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const ProgressDialog(text: Strings.loadingLogin));

    final User? user = (await _auth
            .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
            .catchError((exception) {
      Navigator.pop(context);
      FirebaseAuthException thisEx = exception;
      showSnackBar(thisEx.message ?? Strings.genericResponseError);
    }))
        .user;

    if (user != null) {
      DatabaseReference userRef = FirebaseDatabase.instance.ref('users/${user.uid}');

      userRef.once().then((resp) => {
            if (resp.snapshot.value != null) {Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false)}
          });
    }
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(Strings.noInternetConnection);
      return;
    }
  }

  void showSnackBar(String title) {
    final snackbar = SnackBar(content: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)));
    _scaffoldKey.currentState?.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const Logo(),
                    const SizedBox(height: 40),
                    const Text(Strings.signIn,
                        textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 25)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: Strings.emailAddress,
                                labelStyle: TextStyle(fontSize: 14.0),
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: Strings.password,
                                  labelStyle: TextStyle(fontSize: 14.0),
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 40),
                          Button(
                            title: Strings.enterBtn,
                            color: RideColors.green,
                            onPressed: () => validateFields(),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: "${Strings.dontHaveAccount} ", style: TextStyle(color: RideColors.textLight)),
                        TextSpan(
                            text: Strings.signUp,
                            style: const TextStyle(color: RideColors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamedAndRemoveUntil(context, RegisterPage.id, (route) => false);
                              }),
                      ])),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
