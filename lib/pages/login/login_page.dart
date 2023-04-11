import 'package:auth_buttons/auth_buttons.dart';
import 'package:bibliobook/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            InkWell(
              child: Container(
                color: Colors.orange[600],
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.robot),
                    SizedBox(width: 8),
                    Text("Iniciar como anonimo")
                  ],
                ),
              ),
              onTap: () {
                // Bloc add event autenticacion con google event
                BlocProvider.of<AuthBloc>(context).add(AnonymousAuthEvent());
              },
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "Utiliza un red social",
                textAlign: TextAlign.center,
              ),
            ),
            GoogleAuthButton(
              onPressed: () {
                // Bloc add event autenticacion con google event
                BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
              },
            ),
            _otherAuthMethods(context),
          ],
        ),
      ),
    );
  }

  Wrap _otherAuthMethods(BuildContext ctx) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        FacebookAuthButton(
          onPressed: () {
            _noAuthProviderSnackbar(ctx);
          },
          style: AuthButtonStyle(
            buttonType: AuthButtonType.icon,
          ),
        ),
        TwitterAuthButton(
          onPressed: () {
            _noAuthProviderSnackbar(ctx);
          },
          style: AuthButtonStyle(
            buttonType: AuthButtonType.icon,
          ),
        ),
        AppleAuthButton(
          onPressed: () {
            _noAuthProviderSnackbar(ctx);
          },
          style: AuthButtonStyle(
            buttonType: AuthButtonType.icon,
          ),
        ),
        HuaweiAuthButton(
          onPressed: () {
            _noAuthProviderSnackbar(ctx);
          },
          style: AuthButtonStyle(
            buttonType: AuthButtonType.icon,
          ),
        ),
        GithubAuthButton(
          onPressed: () {
            _noAuthProviderSnackbar(ctx);
          },
          style: AuthButtonStyle(
            buttonType: AuthButtonType.icon,
          ),
        ),
        EmailAuthButton(
          onPressed: () {
            _noAuthProviderSnackbar(ctx);
          },
          style: AuthButtonStyle(
            buttonType: AuthButtonType.icon,
          ),
        ),
      ],
    );
  }

  void _noAuthProviderSnackbar(BuildContext ctx) {
    // Si  se quiere utilizar otros proveedores de autenticacion
    // 1) registrar en firebase
    // 2) poner metodos en el Bloc con sus eventos y estados
    // 3) cambiar el onPress del boton para mandar evento al Bloc
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("Metodo para autenticar no disponible."),
          backgroundColor: Colors.red,
        ),
      );
  }
}
