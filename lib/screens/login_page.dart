import 'package:ecoride/resources/ride_colors.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:ecoride/screens/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/logo.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 25)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: Strings.emailAddress,
                              labelStyle: TextStyle(fontSize: 14.0),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 10.0)),
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: Strings.password,
                                labelStyle: TextStyle(fontSize: 14.0),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 40),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: RideColors.green,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  Strings.enterBtn,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Brand-Bold'),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "${Strings.dontHaveAccount} ",
                          style: TextStyle(color: RideColors.textLight)),
                      TextSpan(
                          text: Strings.signUp,
                          style: const TextStyle(color: RideColors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamedAndRemoveUntil(
                                context, RegisterPage.id, (route) => false)),
                    ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
