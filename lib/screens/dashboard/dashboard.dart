import 'package:bank_provider/models/cliente.dart';
import 'package:bank_provider/screens/autenticacao/login.dart';
import 'package:bank_provider/screens/dashboard/saldo.dart';
import 'package:bank_provider/models/saldo.dart';
import 'package:bank_provider/screens/deposito/formulario.dart';
import 'package:bank_provider/screens/transferencia/formulario.dart';
import 'package:bank_provider/screens/transferencia/lista.dart';
import 'package:bank_provider/screens/transferencia/ultimas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ByteBank'),
      ),
      body: Column(
        children: [
          Consumer<Cliente>(
            builder: (context, cliente, child) {
              if (cliente.nome != null) {
                return Text(
                  'Olá ${cliente.nome.split(' ')[0]}, seu saldo de hoje é: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                );
              }
              return Text(
                'Olá seu saldo de hoje é: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Receber depósito'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FormularioDeposito();
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Nova Transferência'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FormularioTransferencia();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          UltimasTransferencias(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                      (route) => false);
            },
//            color: Colors.green,
            child: Text('Sair'),
          )
        ],
      ),
    );
  }
}