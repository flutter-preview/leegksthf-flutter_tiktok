import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSeleted = false;

  void _onTap() {
    setState(() {
      _isSeleted = !_isSeleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16, horizontal: Sizes.size24),
        decoration: BoxDecoration(
          color: _isSeleted ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isSeleted ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
