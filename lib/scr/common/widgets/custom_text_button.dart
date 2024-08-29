import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final TextDecoration? textDecoration;
  final bool? isUpperCase;
  final bool? isBold;
  final bool isFilled;
  final Color? outlineColor;
  final double? borderWidth;
  final List<Color>? gradientColors;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.textDecoration,
    this.isUpperCase = false,
    this.isBold = false,
    this.isFilled = true,
    this.outlineColor,
    this.borderWidth,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return isFilled
        ? TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              backgroundColor:
                  backgroundColor ?? Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              ),
            ),
            child: Text(
              isUpperCase == true ? text.toUpperCase() : text,
              style: GoogleFonts.oxygen(
                color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                fontWeight: isBold == true
                    ? FontWeight.bold
                    : fontWeight ?? FontWeight.normal,
                fontSize: fontSize ?? 16.0,
                decoration: textDecoration ?? TextDecoration.none,
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
              gradient: gradientColors != null
                  ? LinearGradient(colors: gradientColors!)
                  : null,
            ),
            child: Container(
              padding: EdgeInsets.all(borderWidth ??
                  2.0), // Adjust this to control the border width
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                border: gradientColors == null
                    ? Border.all(
                        color: outlineColor ??
                            Theme.of(context).colorScheme.primary,
                        width: borderWidth ?? 2.0,
                      )
                    : null,
              ),
              child: OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  padding: padding ??
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  backgroundColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                  ),
                  side: BorderSide.none, // Border handled by the Container
                ),
                child: Text(
                  isUpperCase == true ? text.toUpperCase() : text,
                  style: GoogleFonts.oxygen(
                    color: textColor ?? Theme.of(context).colorScheme.onSurface,
                    fontWeight: isBold == true
                        ? FontWeight.bold
                        : fontWeight ?? FontWeight.normal,
                    fontSize: fontSize ?? 16.0,
                    decoration: textDecoration ?? TextDecoration.none,
                  ),
                ),
              ),
            ),
          );
  }
}
