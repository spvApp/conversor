import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //Mediante la función setState podemos indicar a Flutter que hubo cambios en la data que
  // empleamos para construir nuestro árbol de widgets y debe de actualizar los mismos para
  // que finalmente cambie la interfaz acorde a la data; por otra parte, el Statelesswidget NO
  // permite variar dicho estado.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _medidas = [
    "Metros",
    "Kilometros",
    "Gramos",
    "Kilogramos",
    "Pies",
    "Millas",
    "Libras",
    "Onzas",
  ];

  late String _startM;
  late String _endM;

  late String endValue = "0";

  late int _startI;
  late int _endI;

  final valueController = TextEditingController();

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];

  @override
  void initState() {
    this._startI = 0;
    this._endI = 1;

    this._startM = this._medidas[this._startI];
    this._endM = this._medidas[this._endI];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.lightGreen[700], fontSize: 20);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(
            "Medidor app 2",
          ),
        ),
        body: SingleChildScrollView(
          // El SingleChildScrollView permite agregar UN hijo y luego emplea el scroll de manera automatica.
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Valor",
                  style: labelStyle,
                ),
                TextField(
                  //El campo de tipo TextField es un campo de formulario que permite obtener datos
                  // del usuario, específicamente textos, se emplea para por ejemplo solicitar un
                  // nombre, apellido, ciudad y datos similares.
                  controller: valueController,
                  decoration: InputDecoration(
                      hintText: "Valor inicial",
                      contentPadding: EdgeInsets.all(8)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "De",
                  style: labelStyle,
                ),
                DropdownButton(
                  isExpanded: true,
                  value: _startM,
                  items: _medidas.map((m) {
                    return DropdownMenuItem(
                        value: m,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(m),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startM = value.toString();
                      _startI = (_medidas.indexOf(_startM));
                    });
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Para",
                  style: labelStyle,
                ),
                DropdownButton(
                  isExpanded: true,
                  value: _endM,
                  items: _medidas.map((m) {
                    return DropdownMenuItem(
                        value: m,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(m),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _endM = value.toString();
                      _endI = (_medidas.indexOf(_endM));
                    });
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      //obtebemos el valor del usuario.
                      final value = double.parse(valueController.text.trim());

                      setState(() {
                        //aplicamos los calculos.
                        this.endValue = "${value * _formulas[_startI][_endI]}";
                      });
                      //ocultar teclado.
                      FocusScope.of(context).requestFocus(FocusNode());
                    } catch (e) {
                      print("Problemas con la conversiion");
                    }
                    print(valueController.text);
                  },
                  child: Text("Convertir"),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Resultado: $endValue",
                  style: labelStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
