import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  String _info = "Informe os seus dados";

  void _resetField(){
    peso.text = "";
    altura.text = "";
    setState(() {
      _info = "Informe os seus dados";
      _formKey= GlobalKey<FormState>();
    });
  }

  void _calcImc(){
    setState(() {
      double pesoCalc = double.parse(peso.text);
      double alturaCalc = double.parse(altura.text)/100;

      double imc = pesoCalc / (alturaCalc*alturaCalc);

      if(imc < 18.6){
        _info = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _info = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _info = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 34.9 && imc < 40){
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if(imc > 40){
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: _resetField,
            ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Icon(
          Icons.person_outline,
          size: 100.0,
          color: Colors.green,
        ),
        TextFormField(
          validator: (value){
            if(value.isEmpty){
              return "Informe o seu peso";
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Peso em (kg)",
            labelStyle: TextStyle(
              color: Colors.green,
              fontSize: 15.0
              ),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0),
          controller: peso,
        ),
        TextFormField(
          validator: (value){
            if(value.isEmpty){
              return "Informe a sua altura";
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Altura em (cm)",
            labelStyle: TextStyle(
              color: Colors.green,
              fontSize: 15.0
              ),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0),
          controller: altura,
        ),
        Container(
          height: 50.0,
          margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
          child: RaisedButton(
          onPressed: (){
            if(_formKey.currentState.validate()){
              _calcImc();
            }
          },
          child: Text("Calcular", 
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          color: Colors.green,
          ),
        ),
        Text(_info,
        textAlign: TextAlign.center,
        style: TextStyle(color:Colors.green, fontSize: 20.0),),
      ],
      ),
          )
      ),
    );
  }
}
