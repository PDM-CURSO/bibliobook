import 'package:bibliobook/pages/home/home_page.dart';
import 'package:bibliobook/providers/choose_picture_provider.dart';
import 'package:bibliobook/providers/record_audio_provider.dart';
import 'package:bibliobook/providers/search_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'auth/bloc/auth_bloc.dart';
import 'pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(VerifyAuthEvent())),
        ChangeNotifierProvider(
            create: (context) => SearchProvider()..fetchBooks()),
        ChangeNotifierProvider(create: (context) => ChoosePictureProvider()),
        ChangeNotifierProvider(create: (context) => RecordAudioProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            // TODO: revisar bug que no encuentra scaffold
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text("Favor de autenticarse. ${state.eMsg}"),
            //   ),
            // );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return LoginPage();
          }
          return Center(
            child: CircularProgressIndicator(),
          ); // TODO: replace with Splash screen page (opcional)
        },
      ),
    );
  }
}
