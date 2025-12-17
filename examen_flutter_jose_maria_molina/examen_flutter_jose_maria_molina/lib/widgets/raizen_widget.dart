import 'package:flutter/material.dart';
import 'package:flutter_jose_maria_molina/core/app_colors.dart';

class RayzenWidget extends StatefulWidget {
  const RayzenWidget({super.key});

  @override
  State<RayzenWidget> createState() => _RayzenWidgetState();
}

class _RayzenWidgetState extends State<RayzenWidget> {
  String selectedProcesor = '';

  Map<String, bool> procesadorMap = {
    'Rayzen 3': false,
    'Rayzen 5': false,
    'Rayzen 7': false,
    'Rayzen 9': false,
  };

  @override
  Widget build(BuildContext context) {
    final procesorList = procesadorMap.keys.toList();
    return Center(
      child: Column(
        children: [
          Text("Elige tus favoritos"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Text(
                  procesorList[0],
                  style: TextStyle(fontSize: 14, color: AppColorsLight().text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Checkbox(
                  value: procesadorMap[procesorList[0]],
                  onChanged: (bool? value) {
                    setState(() {
                      procesadorMap[procesorList[0]] = value ?? false;
                    });

                    if (value == true) {
                      addProcesor(procesorList[0]);
                    } else {
                      removeProcesor(procesorList[0]);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Text(
                  procesorList[1],
                  style: TextStyle(fontSize: 14, color: AppColorsLight().text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Checkbox(
                  value: procesadorMap[procesorList[1]],
                  onChanged: (bool? value) {
                    setState(() {
                      procesadorMap[procesorList[1]] = value ?? false;
                    });

                    if (value == true) {
                      addProcesor(procesorList[1]);
                    } else {
                      removeProcesor(procesorList[1]);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Text(
                  procesorList[2],
                  style: TextStyle(fontSize: 14, color: AppColorsLight().text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Checkbox(
                  value: procesadorMap[procesorList[2]],
                  onChanged: (bool? value) {
                    setState(() {
                      procesadorMap[procesorList[2]] = value ?? false;
                    });

                    if (value == true) {
                      addProcesor(procesorList[2]);
                    } else {
                      removeProcesor(procesorList[2]);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Text(
                  procesorList[3],
                  style: TextStyle(fontSize: 14, color: AppColorsLight().text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16),
                child: Checkbox(
                  value: procesadorMap[procesorList[3]],
                  onChanged: (bool? value) {
                    setState(() {
                      procesadorMap[procesorList[3]] = value ?? false;
                    });

                    if (value == true) {
                      addProcesor(procesorList[3]);
                    } else {
                      removeProcesor(procesorList[3]);
                    }
                  },
                ),
              ),
            ],
          ),
          Text("Seleccionados: $selectedProcesor"),
        ],
      ),
    );
  }

  void addProcesor(String s) {
    setState(() {
      selectedProcesor += '$s | ';
    });
  }

  void removeProcesor(String s) {
    setState(() {
      selectedProcesor = selectedProcesor.replaceAll('$s | ', '');
    });
  }
}
