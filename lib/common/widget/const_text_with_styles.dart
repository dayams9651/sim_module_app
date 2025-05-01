import 'package:flutter/material.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';

Text const17BoldText(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kBody18SemiBoldTextStyle.copyWith(color: textColor),
  );
}

Text const17Text(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kBody18RegularTextStyle.copyWith(color: textColor),
  );
}

Text const15BoldText(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kBody18SemiBoldTextStyle.copyWith(color: textColor),
  );
}

Text const15Text(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kBody18RegularTextStyle.copyWith(color: textColor),
  );
}

Text const12Text(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kCaption14RegularTextStyle.copyWith(color: textColor),
  );
}

Text const12TextBold(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kCaption14SemiBoldTextStyle.copyWith(color: textColor),
  );
}


Text const10TextBold(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall10SemiBoldTextStyle.copyWith(color: textColor),
  );
}

Text const10Text(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: textColor),
  );
}

Text const8Text(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall8RegularTextStyle.copyWith(color: textColor),
  );
}

Text const8TextBold(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall8SemiBoldTextStyle.copyWith(color: textColor),
  );
}

Text const6Text(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall8RegularTextStyle.copyWith(color: textColor),
  );
}

Text const6TextBold(String text, {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall8SemiBoldTextStyle.copyWith(color: textColor),
  );
}

Text const6TextBoldUnderLine(String text,
    {Color textColor = AppColors.white100}) {
  return Text(
    text,
    style: AppTextStyles.kSmall8SemiBoldTextStyle
        .copyWith(color: textColor, decoration: TextDecoration.lineThrough),
  );
}

textWithoutStyle(text, style) {
  return Text(
    // textAlign: TextAlign.center,
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}
