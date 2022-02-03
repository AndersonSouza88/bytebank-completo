import 'package:bank_provider/models/transferencias.dart';
import 'package:bank_provider/screens/autenticacao/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cliente.dart';
import 'models/saldo.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => Saldo(0),
    ),
    ChangeNotifierProvider(
      create: (context) => Transferencias(),
    ),
    ChangeNotifierProvider(
      create: (context) => Cliente(),
    ),
  ],
  child: BytebankApp(),
));

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent[900],
        accentColor: Color.fromRGBO(38, 101, 8, 1.0),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}