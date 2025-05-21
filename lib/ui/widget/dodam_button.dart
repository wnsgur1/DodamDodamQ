import 'package:flutter/material.dart';

class DodamButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const DodamButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0083F0), // primaryNormal
          foregroundColor: Colors.white,             // staticWhite
          minimumSize: const Size.fromHeight(48),    // Large 버튼 높이
          padding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 28,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // medium shape
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // SemiBold
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
