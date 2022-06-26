import 'package:ecoride/resources/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                  const Image(
                    image: AssetImage('images/logo.png'),
                    alignment: Alignment.center,
                    height: 100.0,
                    width: 100.0,
                  ),
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
                              primary: Colors.green,
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
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: Strings.signUpLink,
                          style: const TextStyle(color: Colors.green),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
