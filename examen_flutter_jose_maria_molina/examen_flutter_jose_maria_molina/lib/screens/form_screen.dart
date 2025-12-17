import 'package:flutter/material.dart';
import 'package:flutter_jose_maria_molina/core/app_colors.dart';
import 'package:flutter_jose_maria_molina/screens/random_screen.dart';
import 'package:flutter_jose_maria_molina/widgets/intel_widget.dart';
import 'package:flutter_jose_maria_molina/widgets/raizen_widget.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Widget formulario = RayzenWidget();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RandomScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsLight().secondary,
                  ),
                  child: Text(
                    "Ejercicio 3",
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
        appBar: AppBar(
          backgroundColor: AppColorsLight().primary,
          title: Text(
            "Ejercicio 2",
            style: TextStyle(fontSize: 20, color: AppColorsLight().text),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: AppColorsLight().background,
        body: Column(
          children: [
            SwitchListTile(
              title: Text(formulario is RayzenWidget ? "AMD" : "Intel"),
              value: formulario is RayzenWidget,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    formulario = RayzenWidget();
                  } else {
                    formulario = IntelWidget();
                  }
                });
              },
            ),
            formulario,
          ],
        ),
      ),
    );
  }
}
