import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../resources/strings.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                  const Text(Strings.signUp,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 25)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: Strings.fullName,
                              labelStyle: TextStyle(fontSize: 14.0),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 10.0)),
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
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
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: Strings.phoneNumber,
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
                                  Strings.createBtn,
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
                          text: "${Strings.haveAccount} ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: Strings.signInLink,
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
