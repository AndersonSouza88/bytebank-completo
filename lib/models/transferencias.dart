import 'package:bank_provider/models/transferencia.dart';
import 'package:flutter/material.dart';

class Transferencias extends ChangeNotifier{
  final List<Transferencia> _transferencias = [];

  List<Transferencia> get transferencias => _transferencias;

  adiciona(Transferencia novaTransferencia){
    transferencias.add(novaTransferencia);
    notifyListeners();
  }
}