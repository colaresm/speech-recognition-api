import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isActive;
  final String text;

  const DefaultButton({
    super.key,
    required this.width,
    required this.onPressed,
    this.isLoading = false,
    this.isActive = false,
    this.text="registrar",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading || !isActive ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.black : Colors.grey,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            :  Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
