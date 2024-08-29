import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final int? maxline;
  final int? maxLength;
  final double? height;
  final double? hintSize;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final String? hint;
  final String? labelText;
  final String? initialValue;
  final bool? obscureText;
  final bool filled;
  final bool? isCollapsed;
  final bool? isDense;
  final bool? isEnabled;
  final bool? readOnly;
  final Color? fillColor;
  final Color? hintcolor;
  final Color? inputColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputDecoration? customDecoration;
  final String? semanticLabel;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextEditingController? controller;
  final ValidationType? validationType;

  const CustomTextFormField({
    super.key,
    this.maxline,
    this.maxLength,
    this.height,
    this.hintSize,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.contentPadding,
    this.hint,
    this.labelText,
    this.initialValue,
    this.obscureText,
    this.filled = true,
    this.isCollapsed,
    this.isDense,
    this.isEnabled,
    this.readOnly,
    this.fillColor,
    this.hintcolor,
    this.inputColor,
    this.borderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.inputAction,
    this.autoValidateMode,
    this.textStyle,
    this.errorTextStyle,
    this.customDecoration,
    this.semanticLabel,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.controller,
    this.validationType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      cursorColor: cursorColor ?? Theme.of(context).colorScheme.primary,
      maxLines: maxline ?? 1,
      textInputAction: inputAction,
      initialValue: initialValue,
      style: textStyle ??
          GoogleFonts.oxygen(
            color: inputColor ?? Theme.of(context).colorScheme.onSurface,
            fontSize: hintSize ?? MediaQuery.of(context).size.width * 0.04,
          ),
      autofocus: false,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters ?? _getInputFormatters(),
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      readOnly: readOnly ?? false,
      enabled: isEnabled ?? true,
      decoration: customDecoration ??
          InputDecoration(
            labelText: labelText,
            counterText: '',
            hintText: hint,
            hintStyle: GoogleFonts.oxygen(
                color: hintcolor ?? const Color(0xFF949494), fontSize: 14),
            filled: filled,
            fillColor: isEnabled == false
                ? Theme.of(context).colorScheme.outlineVariant
                : Theme.of(context).colorScheme.surface,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: horizontalPadding ?? 20.0,
                    vertical: verticalPadding ?? 10),
            errorStyle: errorTextStyle ??
                TextStyle(color: Theme.of(context).colorScheme.error),
            errorMaxLines: 2,
            isCollapsed: isCollapsed ?? false,
            isDense: isDense,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColor ?? Theme.of(context).colorScheme.primary,
                    width: 1),
                borderRadius: BorderRadius.circular(borderRadius ?? 17)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      focusBorderColor ?? Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 17)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 17)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 17)),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
            ),
            // semanticLabel: semanticLabel,
          ),
      validator: (value) => _validateInput(value),
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: onTapOutside ??
          (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
    );
  }

  String? _validateInput(String? value) {
    switch (validationType) {
      case ValidationType.email:
        if (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        break;
      case ValidationType.password:
        if (value == null || value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        break;
      case ValidationType.phoneNumber:
        if (value == null || !RegExp(r'^\d{10,11}$').hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
        break;
      case ValidationType.cnic:
        if (value == null || !RegExp(r'^\d{13}$').hasMatch(value)) {
          return 'CNIC must be 13 digits';
        }
        break;
      case ValidationType.name:
        if (value == null || !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
          return 'Please enter a valid name';
        }
        break;
      case ValidationType.url:
        if (value == null ||
            !RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$').hasMatch(value)) {
          return 'Please enter a valid URL';
        }
        break;
      case ValidationType.number:
        if (value == null || !RegExp(r'^\92\d{10}$').hasMatch(value)) {
          return 'Please enter a valid phone number starting with +92';
        }
        break;
      case ValidationType.none:
      default:
        break;
    }
    return null;
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (validationType) {
      case ValidationType.email:
        return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
      case ValidationType.phoneNumber:
      case ValidationType.cnic:
      case ValidationType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case ValidationType.name:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))];
      case ValidationType.password:
        return [FilteringTextInputFormatter.singleLineFormatter];
      case ValidationType.url:
      case ValidationType.none:
      default:
        return null;
    }
  }
}

enum ValidationType {
  none,
  email,
  password,
  phoneNumber,
  cnic,
  name,
  url,
  number,
}
