import 'package:flutter/material.dart';
import 'package:simplebankingapp/src/views/widgets/text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final EdgeInsets padding;
  final double elevation;

  const CustomButton({
    Key? key,
    this.text = "",
    this.onPressed,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.color = const Color(0xFF2c2c54),
    this.textColor = Colors.white,
    this.height = 50,
    this.borderRadius = 5,
    this.padding = const EdgeInsets.all(0),
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
          enableFeedback: true,
          primary: color,
          padding: padding,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide.none),
      child: CustomText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: textAlign,
        color: textColor,
      ),
    );
  }
}
