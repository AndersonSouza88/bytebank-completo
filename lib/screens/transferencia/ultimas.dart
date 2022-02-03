import 'package:bank_provider/models/transferencias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lista.dart';

final _titulo = 'Ultimas Transferências';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, listaTransferencias, child) {
            final _ultimasTransferencias =
                listaTransferencias.transferencias.reversed.toList();
            final _quantidade = listaTransferencias.transferencias.length;
            int tamanho = 4;

            if (_quantidade == 0) {
              return SemTransferenciaCadastrada();
            }

            if (_quantidade < 4) {
              tamanho = _quantidade;
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tamanho,
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                return ItemTransferencia(_ultimasTransferencias[indice]);
              },
            );
          },
        ),
        ElevatedButton(
          child: Text('Transferências'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListaTransferencias();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Não existem transferências',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
