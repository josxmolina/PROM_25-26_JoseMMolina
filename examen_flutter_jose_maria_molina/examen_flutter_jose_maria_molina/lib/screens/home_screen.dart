import 'package:flutter/material.dart';
import 'package:flutter_jose_maria_molina/core/app_colors.dart';
import 'package:flutter_jose_maria_molina/core/app_text.dart';
import 'package:flutter_jose_maria_molina/screens/form_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
   final ValueChanged<bool>? onThemeChanged;
  const HomeScreen({super.key, this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageSize = size.shortestSide * 0.5;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColorsLight().background
          : AppColorsDark().background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? AppColorsLight().primary
            : AppColorsDark().primary,
        title: Text(
          "José Mª Molina Fdez-Crehuet | 2º DAM",
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).brightness == Brightness.light
                ? AppColorsLight().text
                : AppColorsDark().text,
          ),
          textAlign: TextAlign.center,
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
                    MaterialPageRoute(builder: (context) => FormScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                      ? AppColorsLight().secondary
                      : AppColorsDark().secondary,
                ),
                child: Text(
                  "Ejercicio 2",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColorsLight().text
                        : AppColorsDark().text,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/pajaro.png", height: imageSize),
            Text(
              "José Mª Molina Fdez-Crehuet",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColorsLight().text
                    : AppColorsDark().text,
                fontSize: 24,
              ),
            ),
            SwitchListTile(
              title: Text(
                isDark ? 'Tema Oscuro' : 'Tema Claro',
                style: AppText().normal,
              ),
              secondary: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              value: isDark,
              onChanged: (value) => widget.onThemeChanged?.call(value),
            ),
          ],
        ),
      ),
    );
  }
}
