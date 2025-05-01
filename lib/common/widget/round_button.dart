import 'package:flutter/material.dart';

import '../../style/color.dart';
import '../../style/text_style.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Icon? icon;
  final Color? color;

  const RoundButton({
    super.key,
    this.color,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primaryColor;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: loading
                ? CircularProgressIndicator(
                strokeWidth: 3, color: Colors.white)
                : Text(
              title,
              style: AppTextStyles.kPrimaryTextStyle.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
