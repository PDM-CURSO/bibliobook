import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Sign In",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Image.asset(
              "assets/icons/app_icon.png",
              height: 120,
            ),
            SizedBox(height: 200),
            MaterialButton(
              child: Text("Iniciar como anonimo"),
              color: Colors.grey,
              onPressed: () {
                // TODO: implementar autenticacion con google event
              },
            ),
            Text(
              "Utiliza un red social",
            ),
            MaterialButton(
              child: Text("Iniciar con Google"),
              color: Colors.green,
              onPressed: () {
                // TODO: implementar autenticacion con google event
              },
            ),
          ],
        ),
      ),
    );
  }
}
