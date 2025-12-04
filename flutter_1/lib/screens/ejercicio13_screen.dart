import 'package:flutter/material.dart';
import 'package:flutter_1/core/app_colors.dart';
import 'package:flutter_1/widgets/appbar_widget.dart';
import 'dart:math';
import 'dart:async';
import '../drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomImageGame extends StatefulWidget {
  const RandomImageGame({super.key});

  @override
  State<RandomImageGame> createState() => _RandomImageGameState();
}

class _RandomImageGameState extends State<RandomImageGame> {
  int points = 0;
  int timePerImage = 4;
  int timeRemaining = 4;
  double imageX = 100.0;
  double imageY = 200.0;
  Timer? _imageTimer;
  bool gameActive = true;
  int totalImages = 0;
  Timer? _saveTimer;

  final double imageSize = 80.0;

  @override
  void initState() {
    super.initState();
    _cargarDatos().then((_) {
      if (mounted) {
        Future.delayed(Duration.zero, () {
          if (totalImages == 0) {
            generateRandomPosition();
          }
          startImageTimer();
        });
      }
    });
  }

  Future<void> _cargarDatos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;
      setState(() {
        points = prefs.getInt('game_points') ?? 0;
        totalImages = prefs.getInt('game_totalImages') ?? 0;
        imageX = prefs.getDouble('last_imageX') ?? 100.0;
        imageY = prefs.getDouble('last_imageY') ?? 200.0;
        timeRemaining = prefs.getInt('time_remaining') ?? timePerImage;
      });

      // Clamp restored position to current screen after first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final sidePadding = 20.0;
        final topPadding = 150.0;
        final bottomPadding = 180.0;
        final maxX = screenWidth - (sidePadding * 2) - imageSize;
        final maxY = screenHeight - topPadding - bottomPadding - imageSize;
        setState(() {
          if (imageX < sidePadding || imageX > maxX) imageX = sidePadding + (maxX / 2);
          if (imageY < topPadding || imageY > maxY) imageY = topPadding + (maxY / 2);
          if (timeRemaining > timePerImage || timeRemaining < 0) timeRemaining = timePerImage;
        });
      });
    } catch (e) {
      // If prefs fail, keep defaults and continue
    }
  }

  Future<void> _guardarDatos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('game_points', points);
      await prefs.setInt('game_totalImages', totalImages);
      await prefs.setDouble('last_imageX', imageX);
      await prefs.setDouble('last_imageY', imageY);
      await prefs.setInt('time_remaining', timeRemaining);
    } catch (e) {
      // ignore save errors
    }
  }

  Future<void> _limpiarDatos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('game_points');
      await prefs.remove('game_totalImages');
      await prefs.remove('last_imageX');
      await prefs.remove('last_imageY');
      await prefs.remove('time_remaining');
    } catch (e) {
      // ignore
    }
  }

  void generateRandomPosition() {
    if (!mounted) return;

    Random random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final topPadding = 150.0;
    final bottomPadding = 180.0;
    final sidePadding = 20.0;

    final availableWidth = screenWidth - (sidePadding * 2) - imageSize;
    final availableHeight =
        screenHeight - topPadding - bottomPadding - imageSize;

    setState(() {
      imageX = sidePadding + random.nextDouble() * availableWidth;
      imageY = topPadding + random.nextDouble() * availableHeight;
      timeRemaining = timePerImage;
      totalImages++;
    });
  }

  void startImageTimer() {
    _imageTimer?.cancel();
    _imageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          points -= 2;
          generateRandomPosition();
        }
      });
    });
  }

  void onImageTap() {
    if (gameActive && mounted) {
      setState(() {
        points++;
      });
      _scheduleSave();
      generateRandomPosition();
    }
  }

  void restartGame() {
    _imageTimer?.cancel();
    // Make restart async so we wait until prefs are cleared
    () async {
      await _limpiarDatos();
      if (!mounted) return;
      setState(() {
        points = 0;
        totalImages = 0;
        timeRemaining = timePerImage;
        gameActive = true;
      });
      generateRandomPosition();
      startImageTimer();
    }();
  }

  @override
  void dispose() {
    // Ensure any pending save completes
    _saveTimer?.cancel();
    _guardarDatos();
    _imageTimer?.cancel();
    super.dispose();
  }

  void _scheduleSave({Duration delay = const Duration(milliseconds: 500)}) {
    _saveTimer?.cancel();
    _saveTimer = Timer(delay, () {
      _guardarDatos();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColorsLight.background
          : AppColorsDark.background,
      drawer: const DrawerMenu(),
      appBar: const AppbarWidget(title: "Juego imagen random"),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Puntos: $points',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColorsLight.text
                        : AppColorsDark.text,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Tiempo: ${timeRemaining}s',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: timeRemaining <= 1
                        ? Colors.red
                        : Theme.of(context).brightness == Brightness.light
                        ? AppColorsLight.text
                        : AppColorsDark.text,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Imágenes: $totalImages',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColorsLight.text
                        : AppColorsDark.text,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: imageX,
            top: imageY,
            child: GestureDetector(
              onTap: onImageTap,
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.star, size: 50, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: restartGame,
                icon: const Icon(Icons.refresh),
                label: const Text('Reiniciar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: const Text(
                  '¡Pulsa la estrella antes de que desaparezca!\n+1 punto si pulsas | -2 puntos si no pulsas',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
