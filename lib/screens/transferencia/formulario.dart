import 'package:bank_provider/components/editor.dart';
import 'package:bank_provider/models/saldo.dart';
import 'package:bank_provider/models/transferencia.dart';
import 'package:bank_provider/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNumeroConta,
                dica: _dicaCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta, icone: null,
              ),
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text(_textoBotaoConfirmar),
                onPressed: () => _criaTransferencia(context),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    final transferenciaValida = _validaTransferencia(context, numeroConta, valor);
    if (transferenciaValida) {
      final novaTransferencia = Transferencia(valor!, numeroConta!);
      _atualizaEstado(context, novaTransferencia, valor);
      Navigator.pop(context);
    }
    //Implementar mensagem de saldo insuficiente.
  }
  _validaTransferencia(context, numeroConta, valor){
    final _camposPreenchidos = numeroConta != null && valor != null;
    final _saldoSuficiente = (valor > 0 && valor <= Provider.of<Saldo>(context, listen: false).valor);
    if (!_saldoSuficiente)
    {
      if (valor > 0)
      {
        final snackBar = SnackBar(content: Text('Saldo Insuficiente!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else
      {
        final snackBar = SnackBar(content: Text('Valor deve ser maior que 0 (zero) !'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }
    return _camposPreenchidos && _saldoSuficiente;
  }
  
  _atualizaEstado(context, novaTransferencia, valor){
    Provider.of<Transferencias>(context, listen: false).adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }
}
