import 'package:flutter/material.dart';

class primeraVista extends StatefulWidget {
  const primeraVista({super.key});

  @override
  State<primeraVista> createState() => _primeraVistaState();
}

class _primeraVistaState extends State<primeraVista> {

  final _monedas = ["Dolar", "Euro", "yen"];
  var _monedasSelectedItem = "Dolar";
  var mostrarResultado = "";
  

  TextEditingController montoController = TextEditingController();
  TextEditingController tasaController = TextEditingController();
  TextEditingController tiempoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text("Calculadora de interes"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
            children: [
            Image.asset("assets/images/foto1.jpg",
            width: 250.0),
          TextField(
            keyboardType: TextInputType.number,
            controller: montoController,
            decoration: InputDecoration(
              labelText: "Monto Principal",
              hintText: "Introduzca monto principal",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextField(
            controller: tasaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Tasa de interes",
              hintText: "Introduzca un porcentaje de interes",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
          const SizedBox(height: 15),
           Row( 
              children: [
                 Expanded(
                   child: TextField( //el textfield al incio solo se wrap en un widget expanded
                    controller: tiempoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                    labelText: "Tiempo de interes",
                    hintText: "Introduzca en años",
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                                 ),
                               ),
                             ),
                 ),
                 const SizedBox(width: 12.0),
                Expanded(
                  child:DropdownButton( 
                  items: _monedas.map((value){
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                      );
                  }).toList(),
                  onChanged: (newSelectedValue){
                    setState(() {
                     _monedasSelectedItem = newSelectedValue!;
                    });
                  },
                  value: _monedasSelectedItem,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  setState(() {
                   mostrarResultado = calcularInteres();
                  });
                },
                 child: const Text("Calcular"),
                 ),
                 const SizedBox(width: 10.0),
                 ElevatedButton(onPressed: (){
                  setState(() {
                    limpiar();
                  });
                 },
                 child: const Text("Limpiar"),
                 ),
              ],
            ),
            const SizedBox(height: 10.0),
            Center(child: Text(mostrarResultado)),
          ],
        ),
      );
  }

   String calcularInteres(){
      double monto = double.parse(montoController.text);
      double tasa = double.parse(tasaController.text);
      double tiempo = double.parse(tiempoController.text);
      
      double totalPagar = monto + (monto + tasa + tiempo)/100;
      String resultado = "Despues de $tiempo años, tu inversion valdra $totalPagar en $_monedasSelectedItem";
      return resultado;
    }

    void limpiar(){
      montoController.text = "";
      tasaController.text = "";
      tiempoController.text = "";
      _monedasSelectedItem = _monedas[0];
      mostrarResultado = "";
    }
}