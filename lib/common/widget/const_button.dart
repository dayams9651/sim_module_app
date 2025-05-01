import 'package:flutter/material.dart';

import '../../style/color.dart';

class ConstButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color? color;
  const ConstButton({super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            border: Border.all(color: AppColors.primaryColor, width: 2),

          ),
          child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.grey,):Text(title,
            style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),),),
        ),
      ),
    );
  }
}