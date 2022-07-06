import 'package:ecoride/providers/app_data.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:ecoride/screens/home_page.dart';
import 'package:ecoride/screens/login_page.dart';
import 'package:ecoride/screens/register_page.dart';
import 'package:ecoride/helpers/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    name: dotenv.get('DB_NAME'),
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: HomePage.id,
          routes: {
            RegisterPage.id: ((context) => const RegisterPage()),
            LoginPage.id: ((context) => const LoginPage()),
            HomePage.id: ((context) => const HomePage())
          }),
    );
  }
}
