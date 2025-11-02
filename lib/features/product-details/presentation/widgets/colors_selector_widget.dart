import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black,
  ];
  Color selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          colors.map((color) {
            final isSelected = (color == selectedColor);
            return GestureDetector(
              onTap: () => setState(() => selectedColor = color),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey.shade300,
                    width: isSelected ? 3 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
