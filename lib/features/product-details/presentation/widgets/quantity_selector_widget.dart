import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final Function(int) onQuantityChanged;
  const QuantitySelector({super.key, required this.onQuantityChanged});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (quantity > 1) {
                setState(() => quantity--);
                widget.onQuantityChanged(quantity);
              }
            },
            child: const Icon(
              Icons.remove_circle_outline,
              color: Colors.white,
              size: 25,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() => quantity++);
              widget.onQuantityChanged(quantity);
            },
            child: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
