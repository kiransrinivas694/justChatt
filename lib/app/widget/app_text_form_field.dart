import 'package:chatapp_ksn/app/utils/app_utils.dart';
import 'package:chatapp_ksn/app/widget/app_image_assets.dart';
import 'package:chatapp_ksn/app/widget/app_text.dart';
import 'package:chatapp_ksn/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final Icon? suffixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onSuffixTap;
  final TextInputType? keyboardType;
  final TextStyle? hintTextStyle;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final double? fontSize;
  final TextEditingController textEditingController;
  final String? errorText;
  final bool readOnly;
  final bool autoFocus;
  final bool isMaxLines;
  final double borderRadius;
  final double? contentPadding;
  final double leftPadding;
  final double? maxHeight;
  final Color? fillColor;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType,
    this.hintTextStyle,
    this.maxLines = 1,
    this.fontSize,
    this.inputFormatters,
    this.errorText,
    this.readOnly = false,
    this.autoFocus = false,
    this.isMaxLines = false,
    this.borderRadius = 6,
    this.leftPadding = 20,
    this.contentPadding,
    this.maxHeight,
    this.fillColor,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: isMaxLines ? (maxHeight ?? 180.px) : 50.px,
          padding: EdgeInsets.only(left: leftPadding.px, right: 10.px),
          alignment: isMaxLines ? Alignment.topLeft : Alignment.center,
          decoration: BoxDecoration(
            color: fillColor ?? AppColorConstant.appWhite,
            borderRadius: BorderRadius.circular(borderRadius.px),
            border: Border.all(
                color: errorText == null || errorText!.isEmpty
                    ? AppColorConstant.black
                    : AppColorConstant.red,
                width: 0.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textEditingController,
                  cursorColor: AppColorConstant.appBlack,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  autofocus: autoFocus,
                  textInputAction: textInputAction ?? TextInputAction.next,
                  inputFormatters: inputFormatters,
                  readOnly: readOnly,
                  onTap: onTap,
                  onChanged: onChanged,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: AppColorConstant.appBlack,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.poppins,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: contentPadding ?? 2.px),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: hintText,
                    hintStyle: hintTextStyle ??
                        TextStyle(
                          fontSize: 12.px,
                          fontFamily: AppFont.poppins,
                          letterSpacing: -0.19.px,
                          color: AppColorConstant.grey1,
                        ),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                SizedBox(width: 12.px),
                GestureDetector(
                    onTap: onSuffixTap,
                    child: suffixIcon ?? Icon(Icons.search)),
                SizedBox(width: 12.px),
              ]
            ],
          ),
        ),
        if (errorText != null && errorText!.isNotEmpty) ...[
          SizedBox(height: 1.px),
          AppText(
            errorText ?? '',
            fontSize: 14.px,
            color: AppColorConstant.red,
            fontFamily: AppFont.poppins,
          ),
        ]
      ],
    );
  }
}
