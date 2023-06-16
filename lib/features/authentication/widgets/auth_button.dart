import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final void Function(BuildContext) onTap;

  const AuthButton(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // 부모 크기의 상대적인 크기로 설정됨.
      widthFactor: 1,
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey.shade300, width: Sizes.size1)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: Sizes.size16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
