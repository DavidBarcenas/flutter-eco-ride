import 'package:ecoride/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/logo.dart';
import '../resources/ride_colors.dart';
import '../resources/strings.dart';

class RegisterPage extends StatelessWidget {
  static const String id = 'register';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterPage({Key? key}) : super(key: key);

  void validateFields(BuildContext context) {
    if (fullNameController.text.length < 3) {
      showSnackBar(context, 'Ingresa un nombre válido');
      return;
    }
    if (phoneController.text.length < 10) {
      showSnackBar(context, 'Ingresa un número de celular válido');
      return;
    }
    if (!emailController.text.contains('@')) {
      showSnackBar(context, 'Ingresa un correo electrónico válido');
      return;
    }
    if (passwordController.text.length < 8) {
      showSnackBar(context, 'La contraseña debe tener al menos 8 caracteres');
      return;
    }
    registerUser();
  }

  void registerUser() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text))
        .user;

    if (user != null) {
      print("Registration successful");
    }
  }

  void showSnackBar(BuildContext context, String title) {
    final snackbar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

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
                  const Text(Strings.signUp,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 25)),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: fullNameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: Strings.fullName,
                              labelStyle: TextStyle(fontSize: 14.0),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 10.0)),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: Strings.emailAddress,
                              labelStyle: TextStyle(fontSize: 14.0),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 10.0)),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              labelText: Strings.phoneNumber,
                              labelStyle: TextStyle(fontSize: 14.0),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 10.0)),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: Strings.password,
                                labelStyle: TextStyle(fontSize: 14.0),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 40),
                        Button(
                          title: Strings.createBtn,
                          color: RideColors.green,
                          onPressed: () => validateFields(context),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "${Strings.haveAccount} ",
                          style: TextStyle(color: RideColors.textLight)),
                      TextSpan(
                          text: Strings.signInLink,
                          style: const TextStyle(color: RideColors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamedAndRemoveUntil(
                                context, LoginPage.id, (route) => false)),
                    ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
