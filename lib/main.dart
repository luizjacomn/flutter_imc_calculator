import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _white = Colors.white;
  final _green = Colors.tealAccent;
  final _gray = Colors.blueGrey[200];
  final _dark = Colors.blueGrey[800];
  final _labelButtonSize = 15.0;
  final _labelSize = 20.0;
  final _textFieldSize = 25.0;
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _resultText = '';
  String _info = 'Informe os dados';
  var _resultIcon = Icons.rowing;

  void _reset() {
    _weightController.clear();
    _heightController.clear();

    setState(() {
      _info = 'Informe os dados';
      _resultText = '';
      _resultIcon = Icons.rowing;
    });
  }

  void _calculate() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    double imc = weight / (height * height);

    setState(() {
      if (imc < 18.6) {
        _resultText = '${imc.toStringAsPrecision(3)} - Abaixo do peso';
        _resultIcon = Icons.sentiment_neutral;
      } else if (imc >= 18.6 && imc < 24.9) {
        _resultText = '${imc.toStringAsPrecision(3)} - Peso deal';
        _resultIcon = Icons.sentiment_very_satisfied;
      } else if (imc >= 24.9 && imc < 29.9) {
        _resultText = '${imc.toStringAsPrecision(3)} - Levemente acima do peso';
        _resultIcon = Icons.sentiment_satisfied;
      } else if (imc >= 29.9 && imc < 34.9) {
        _resultText = '${imc.toStringAsPrecision(3)} - Obesidade Grau I';
        _resultIcon = Icons.sentiment_neutral;
      } else if (imc >= 34.9 && imc < 39.9) {
        _resultText = '${imc.toStringAsPrecision(3)} - Obesidade Grau II';
        _resultIcon = Icons.sentiment_dissatisfied;
      } else {
        _resultText = '${imc.toStringAsPrecision(3)} - Obesidade Grau III';
        _resultIcon = Icons.sentiment_very_dissatisfied;
      }

      _info = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculadora de IMC",
            style: TextStyle(color: _dark),
          ),
          backgroundColor: _green,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: _dark,
              ),
              onPressed: () {
                _reset();
              },
            )
          ],
        ),
        backgroundColor: _dark,
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  _resultIcon,
                  size: 120.0,
                  color: _gray,
                ),
              ),
              Text(
                _resultText,
                textAlign: TextAlign.center,
                style: TextStyle(color: _white, fontSize: _labelSize),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  focusNode: _weightFocus,
                  onFieldSubmitted: (term) {
                    _weightFocus.unfocus();
                    FocusScope.of(context).requestFocus(_heightFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'Informe o peso';
                  },
                  decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: _gray, fontSize: _labelSize),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _green, fontSize: _textFieldSize),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _green, fontSize: _textFieldSize),
                  onFieldSubmitted: (value) {
                    _weightFocus.unfocus();
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'Informe a altura';
                  },
                  decoration: InputDecoration(
                    labelText: 'Altura (m)',
                    labelStyle: TextStyle(fontSize: _labelSize, color: _gray),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FloatingActionButton.extended(
                  icon: Icon(
                    Icons.beenhere,
                    color: _dark,
                  ),
                  backgroundColor: _green,
                  label: Text(
                    'Calcular IMC',
                    style: TextStyle(color: _dark, fontSize: _labelButtonSize),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) _calculate();
                  },
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _white, fontSize: _labelSize),
                ),
              )
            ],
          ),
        )));
  }
}
