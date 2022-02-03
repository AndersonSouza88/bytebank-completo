import 'dart:ffi';

import 'package:bank_provider/components/mensagem.dart';
import 'package:bank_provider/screens/autenticacao/registrar.dart';
import 'package:bank_provider/screens/dashboard/dashboard.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 455,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _construirFormulario(context),
                    /*  child: Column(
                      children: [
                        Text(
                          'Faça seu login: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'CPF',
                          ),
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          controller: _cpfController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                          ),
                          maxLength: 16,
                          keyboardType: TextInputType.text,
                          controller: _senhaController,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlineButton(
                            textColor: Theme
                                .of(context)
                                .accentColor,
                            highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                            ),
                            onPressed: () {
                              if (_validaCampos()) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ),
                                        (route) => false);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('ATENÇÃO !!!'),
                                      content: Text('CPF ou Senha incorreto!!'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Fechar'))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text('Continuar'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Esqueci minha Senha >',
                          style: TextStyle(
                            color: Theme
                                .of(context)
                                .accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        OutlineButton(
                          textColor: Theme
                              .of(context)
                              .accentColor,
                          highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme
                                .of(context)
                                .accentColor,
                          ),
                          child: Text(
                            'Criar uma Conta >',
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),*/
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  /* bool _validaCampos() {
    if (_cpfController.text.length > 0 && _senhaController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }*/

  Widget _construirFormulario(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Faça seu login: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
            ),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) {
              if (value!.length == 0) {
                return 'Informe o CPF!!';
              }
              if (value.length < 14) {
                return 'CPF inválido';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            maxLength: 16,
            validator: (value) {
              if (value!.length == 0) {
                return 'Informe uma Senha!!';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              textColor: Theme.of(context).accentColor,
              highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_cpfController.text == '123.456.789-01' &&
                      _senhaController.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                        (route) => false);
                  } else {
                    exiberAlerta(
                      context: context,
                      titulo: 'ATENÇÃO!!',
                      content: 'CPF OU Senha Incorretos!',
                    );
                  }
                }
              },
              /*else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('ATENÇÃO !!!'),
                          content: Text('CPF ou Senha incorreto!!'),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Fechar'))
                          ],
                        );
                      },
                    );
                  }*/
              child: Text('Continuar'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Esqueci minha Senha >',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),

          OutlineButton(
            textColor: Theme.of(context).accentColor,
            highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
            child: Text(
              'Criar uma Conta >',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registrar()),
              );
            },


          ),

        ],
      ),
    );
  }
}
