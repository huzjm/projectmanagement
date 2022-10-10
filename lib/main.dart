import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hes_pm/provider/provider.dart';
import 'package:hes_pm/screens/authpage.dart';
import 'package:hes_pm/screens/homepage.dart';
import 'package:hes_pm/screens/login.dart';

import 'package:hes_pm/shared/size_config.dart';
import 'package:provider/provider.dart';
import 'shared/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ListenableProvider<MainProvider>(create: (ctx)=>MainProvider())
      ],
      child: MaterialApp(


        title: 'HES',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: auth.authStateChanges(),
          builder: ( context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return Center(child: CircularProgressIndicator());
            }
            final user = snapshot.data;
            if (user != null
                ) {

              return HomePage();
            } else {

              return AuthPage();
            }
          },
        ),


      ),
    );
  }
}

