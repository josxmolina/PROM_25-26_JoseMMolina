import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_jose_maria_molina/core/app_colors.dart';
import 'package:flutter_jose_maria_molina/core/app_text.dart';
import 'package:flutter_jose_maria_molina/screens/home_screen.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  int suma = 0;
  String textoReinicio = "";
  String textoVictoria = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight().background,
      appBar: AppBar(
        backgroundColor: AppColorsLight().primary,
        title: Text(
          "Ejercicio 2",
          style: TextStyle(fontSize: 20, color: AppColorsLight().text),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(suma.toString(), style: AppText().cabecera),
            Text(
              textoReinicio,
              style: TextStyle(color: Colors.red, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              textoVictoria,
              style: TextStyle(color: Colors.green, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (suma > 51) {
                          setState(() {
                            textoReinicio =
                                "HA PERDIDO POR FAVOR PULSE REINICIAR";
                          });
                        } else if (suma < 51) {
                          setState(() {
                            int numeroAleatorio = Random().nextInt(6) + 1;
                            suma += numeroAleatorio;
                          });
                        } else {
                          setState(() {
                            textoVictoria = "HAS GANADO!!!";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorsLight().secondary,
                      ),
                      child: Text("Sumar", style: AppText().normal),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          suma = 0;
                          textoReinicio = "";
                          textoVictoria = "";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorsLight().primary,
                      ),
                      child: Text("Reiniciar", style: AppText().normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsLight().secondary,
                  ),
                  child: Text(
                    "Ejercicio 1",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColorsLight().text,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
