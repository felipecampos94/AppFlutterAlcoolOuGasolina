import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController gasolinaController = TextEditingController();
  TextEditingController alcoolController = TextEditingController();

  String _infoText = "Informe o valor de cada combustível";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gasolina ou Álcool?"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _ressetaValores();
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.directions_car,
                size: 60.0,
                color: Colors.orange,
              ),
              buildTextFormFieldGasolina(),
              buildTextFormFieldAlcool(),
              buildContainerButton(context),
              buildTextInfo()
            ],
          ),
        ),
      ),
    );
  }

  buildTextFormFieldGasolina() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Preço da Gasolina",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
      style: TextStyle(fontSize: 30.0),
      controller: gasolinaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe o valor da gasolina';
        }
        return null;
      },
    );
  }

  buildTextFormFieldAlcool() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Preço do Álcool",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
      style: TextStyle(fontSize: 30.0),
      controller: alcoolController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe o valor do álcool';
        }
        return null;
      },
    );
  }

  buildContainerButton(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          if (_formkey.currentState.validate()) {
            calcula();
            FocusScope.of(context).requestFocus(new FocusNode());
          }
        },
        child: Text("Calcular",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        color: Colors.orange,
      ),
    );
  }

  buildTextInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 20.0),
    );
  }

  void calcula() {
    setState(() {
      double gasolina = double.parse(gasolinaController.text);
      double alcool = double.parse(alcoolController.text);

      double resultado = (alcool / gasolina);

      if (resultado > 0.70) {
        _infoText =
            "Percentual : (${resultado.toStringAsPrecision(3)})\n\nVale a pena abastecer com Gasolina";
      } else {
        _infoText =
            "Percentual : (${resultado.toStringAsPrecision(3)})\n\nVale a pena abastecer com Álcool";
      }
    });
  }

  _ressetaValores() {
    setState(() {
      gasolinaController.text = "";
      alcoolController.text = "";
      _infoText = "Informe o valor de cada combustível";
    });
  }
}
