import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/screens/home_page.dart';
import 'package:ecoride/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/logo.dart';
import '../resources/ride_colors.dart';
import '../resources/strings.dart';
import '../widgets/progress_dialog.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void validateFields() {
    if (fullNameController.text.length < 3) {
      showSnackBar('Ingresa un nombre válido');
      return;
    }
    if (phoneController.text.length < 10) {
      showSnackBar('Ingresa un número de celular válido');
      return;
    }
    if (!emailController.text.contains('@')) {
      showSnackBar('Ingresa un correo electrónico válido');
      return;
    }
    if (passwordController.text.length < 8) {
      showSnackBar('La contraseña debe tener al menos 8 caracteres');
      return;
    }
    registerUser();
  }

  void registerUser() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const ProgressDialog(text: 'Creando cuenta...'));

    final User? user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((exception) {
      Navigator.pop(context);
      FirebaseAuthException thisEx = exception;
      showSnackBar(thisEx.message ?? 'Algo salió mal. Intentalo más tarde');
    }))
        .user;

    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.ref('users/${user.uid}');

      Map userMap = {
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };
      await newUserRef.set(userMap);

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
    }
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar('No tienes conexión a internet');
      return;
    }
  }

  void showSnackBar(String title) {
    final snackbar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ));
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
                    const Text(Strings.signUp,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontFamily: 'Brand-Bold', fontSize: 25)),
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
                            onPressed: () =>
                                {checkConnectivity(), validateFields()},
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
          )),
    );
  }
}
