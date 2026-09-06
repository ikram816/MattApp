import 'package:flutter/material.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onDelete;
  final VoidCallback onClear;
  final VoidCallback onDot;
  final VoidCallback onEquals;

  const NumericKeypad({
    super.key,
    required this.onNumberPressed,
    required this.onDelete,
    required this.onClear,
    required this.onDot,
    required this.onEquals,
  });

  Widget tombol(
    String text, {
    VoidCallback? onPressed,
    IconData? icon,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 65,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: icon != null
                ? Icon(icon, size: 27)
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1 2 3
        Row(
          children: [
            tombol(
              '1',
              onPressed: () => onNumberPressed('1'),
            ),
            tombol(
              '2',
              onPressed: () => onNumberPressed('2'),
            ),
            tombol(
              '3',
              onPressed: () => onNumberPressed('3'),
            ),
          ],
        ),

        // 4 5 6
        Row(
          children: [
            tombol(
              '4',
              onPressed: () => onNumberPressed('4'),
            ),
            tombol(
              '5',
              onPressed: () => onNumberPressed('5'),
            ),
            tombol(
              '6',
              onPressed: () => onNumberPressed('6'),
            ),
          ],
        ),

        // 7 8 9
        Row(
          children: [
            tombol(
              '7',
              onPressed: () => onNumberPressed('7'),
            ),
            tombol(
              '8',
              onPressed: () => onNumberPressed('8'),
            ),
            tombol(
              '9',
              onPressed: () => onNumberPressed('9'),
            ),
          ],
        ),

        // C 0 .
        Row(
          children: [
            tombol(
              'C',
              onPressed: onClear,
            ),
            tombol(
              '0',
              onPressed: () => onNumberPressed('0'),
            ),
            tombol(
              '.',
              onPressed: onDot,
            ),
          ],
        ),

        // = dan delete
        Row(
          children: [
            tombol(
              '=',
              onPressed: onEquals,
            ),
            tombol(
              '',
              onPressed: onDelete,
              icon: Icons.backspace_outlined,
            ),
          ],
        ),
      ],
    );
  }
}