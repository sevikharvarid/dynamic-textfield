import 'package:dynamic_textfield/src/app_colors.dart';
import 'package:dynamic_textfield/src/app_utils.dart';
import 'package:dynamic_textfield/src/text_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DynamicType{
  inputText,
  dropdown,
}

class DynamicTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label, hint, errorMessage;
  final TextInputType inputType;
  final VoidCallback? onEditComplete;
  final ValueChanged<String>? onChanged;
  final ValueChanged<PointerDownEvent>? onTapOutside;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;
  final VoidCallback? onFieldSubmitted;
  final VoidCallback? onPressedSuffixIcon;
  final bool? isVisible;
  final bool? isPassword;
  final double? widthBorderSide;
  final TextCapitalization? textCapitalization;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final FontWeight? labelFontWeight;
  final GestureTapCallback? onTap;
  final bool? enabled;
  final Widget? prefixIcon;
  final Color? disableFillColor;
  final Color? disableTextColor;

  const DynamicTextField({
    super.key,
    this.controller,
    required this.label,
    required this.hint,
    required this.inputType,
    this.textCapitalization,
    this.inputFormatter,
    this.onEditComplete,
    this.errorMessage,
    this.errorText,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.textColor,
    this.filled,
    this.fillColor,
    this.enabled = true,
    this.onFieldSubmitted,
    this.contentPadding,
    this.isVisible = false,
    this.onPressedSuffixIcon,
    this.widthBorderSide,
    this.isPassword = false,
    this.labelFontWeight,
    this.onTap,
    this.prefixIcon,
    this.disableFillColor,
    this.disableTextColor,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(
            longText: label,
            weight: labelFontWeight,
          ),
          if (label!.isNotEmpty)
            const SizedBox(height: AppUtils.baseWidthHeight10),
          TextFormField(
            autofocus: false,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            focusNode: focusNode,
            controller: controller,
            keyboardType: inputType,
            obscureText: isVisible!,
            inputFormatters: inputFormatter,
            style: TextStyle(
              color:
                  enabled! ? textColor : disableTextColor ?? AppColors.black60,
            ),
            onTap: onTap ?? () {},
            onChanged: onChanged ?? (value) {},
            onEditingComplete: onEditComplete ??
                () {
                  FocusScope.of(context).unfocus();
                },
            validator: validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return errorMessage;
                  }

                  return null;
                },
            onFieldSubmitted: (String value) {
              if (onFieldSubmitted != null) {
                onFieldSubmitted!();
              }
            },
            onTapOutside: onTapOutside,
            decoration: InputDecoration(
              enabled: enabled!,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppUtils.basePaddingMargin16,
                    vertical: AppUtils.basePaddingMargin5 * 3,
                  ),
              isDense: true,
              errorText: errorText,
              hintText: "$hint",
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppUtils.baseRoundedCorner * 5),
                borderSide: BorderSide(
                  color: AppColors.grey400!,
                  width: widthBorderSide ?? 2,
                ),
              ),
              filled: true,
              fillColor: enabled!
                  ? AppColors.white
                  : disableFillColor ?? AppColors.neutral3,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppUtils.baseRoundedCorner * 5,
                ),
                borderSide: BorderSide(
                  color: AppColors.grey400!,
                  width: widthBorderSide ?? 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppUtils.baseRoundedCorner * 5,
                ),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: widthBorderSide ?? 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppUtils.baseRoundedCorner * 5),
                borderSide: BorderSide(
                  color: AppColors.red60,
                  width: widthBorderSide ?? 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppUtils.baseRoundedCorner * 5,
                ),
                borderSide: BorderSide(
                  color: AppColors.red60,
                  width: widthBorderSide ?? 2,
                ),
              ),
              hintStyle: TextStyle(
                  color: AppColors.grey400,
                  fontWeight: FontWeight.normal,
                  fontSize: AppUtils.baseTextSize14),
              errorStyle: TextStyle(
                  color: AppColors.red60,
                  fontWeight: FontWeight.normal,
                  fontSize: AppUtils.baseTextSize14),
              labelStyle: TextStyle(
                  color: AppColors.grey200,
                  fontWeight: FontWeight.normal,
                  fontSize: AppUtils.baseTextSize14),
              errorMaxLines: 2,
              suffixIcon: isPassword!
                  ? IconButton(
                      onPressed: onPressedSuffixIcon,
                      icon: !isVisible!
                          ? Icon(
                              Icons.remove_red_eye,
                              color: AppColors.grey300,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.grey300,
                            ),
                    )
                  : null,
              prefixIcon: prefixIcon,
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          )
        ],
      ),
    );
  }
}
