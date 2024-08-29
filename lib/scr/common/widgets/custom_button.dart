import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? textSize;
  final double? borderRadius;
  final double? elevation;
  final Color? textColor;
  final FontWeight? fontWeight;
  final List<Color>? gradientColors;
  final Color? color; // New parameter for solid color
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool isIconRight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.elevation,
    this.textColor,
    this.fontWeight,
    this.textSize,
    this.borderRadius,
    this.gradientColors,
    this.color, // Initialize new parameter
    this.padding,
    this.width,
    this.height,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.isIconRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        elevation: elevation ?? 0,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: color, // Set the solid color if provided
          gradient: color == null
              ? LinearGradient(
                  colors: gradientColors ??
                      [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                )
              : null, // Use gradient only if color is not provided
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          child: isIconRight
              ? _buildTextWithIcon(context)
              : _buildIconWithText(context),
        ),
      ),
    );
  }

  Widget _buildIconWithText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: iconSize ?? 20,
            color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: GoogleFonts.oxygen(
            color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: textSize ?? 15,
          ),
        ),
      ],
    );
  }

  Widget _buildTextWithIcon(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.oxygen(
            color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: textSize ?? 15,
          ),
        ),
        if (icon != null) ...[
          const SizedBox(width: 8),
          Icon(
            icon,
            size: iconSize ?? 20,
            color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ],
    );
  }
}
