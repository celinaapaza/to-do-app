// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../providers/theme_data_provider.dart';
import '../../../utils/k_colors.dart';

class TextFieldComponent extends StatefulWidget {
  final TextEditingController controller;
  final Function? onTap;
  final bool? obscureText;
  final TextInputType? textType;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final double? prefix;
  final Widget? suffixIcon;
  final double suffix;
  final TextStyle? inputTextStyle;
  final TextStyle? errorTextStyle;
  final String? hintText;
  final String? labelError;
  final TextStyle? hintTextStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusFillColor;
  final Color? unfocusFillColor;
  final bool? expands;
  final bool? alignLabelWithHint;
  final int? maxLines;
  final int? minLines;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final bool showCursor;
  final bool? enableInteractiveSelection;
  final bool? error;
  final bool? hasLabelText;
  final Function(PointerDownEvent)? onTapOutside;
  final BoxConstraints? constraints;
  final void Function(String)? onChanged;
  // O se puede pasar completo un nuevo inputDecoration:
  final InputDecoration? inputDecoration;
  final TextInputAction? textInputAction;

  const TextFieldComponent({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.obscureText,
    this.prefix = 0,
    this.textType,
    this.textInputFormatter,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix = 10,
    this.inputTextStyle,
    this.errorTextStyle,
    this.hintText,
    this.labelError,
    this.hintTextStyle,
    this.backgroundColor,
    this.focusFillColor,
    this.unfocusFillColor,
    this.borderColor,
    this.constraints,
    this.alignLabelWithHint = false,
    this.inputDecoration,
    this.textAlign,
    this.textAlignVertical,
    this.expands = false,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.focusNode,
    this.onTapOutside,
    this.readOnly = false,
    this.showCursor = true,
    this.enabled = true,
    this.enableInteractiveSelection,
    this.error = false,
    this.hasLabelText = true,
    this.textInputAction,
  });

  @override
  TextInputComponentState createState() => TextInputComponentState();
}

class TextInputComponentState extends State<TextFieldComponent> {
  late bool hasText;

  @override
  void initState() {
    super.initState();
    hasText = widget.controller.text.isNotEmpty;
    widget.controller.addListener(() {
      setState(() {
        hasText = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => widget.onTapOutside?.call(event),
      onChanged: (value) => widget.onChanged?.call(value),
      focusNode: widget.focusNode,
      controller: widget.controller,
      onTap: () => widget.onTap?.call(),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      expands: widget.expands!,
      maxLines: widget.expands! ? null : widget.maxLines,
      minLines: widget.expands! ? null : widget.minLines ?? 1,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
      keyboardType: widget.textType ?? TextInputType.text,
      inputFormatters: widget.textInputFormatter,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      obscureText: widget.obscureText ?? false,
      obscuringCharacter: "*",
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      showCursor: widget.showCursor,
      decoration:
          widget.inputDecoration ??
          InputDecoration(
            constraints: widget.constraints,
            hintText: widget.hintText,
            hintStyle:
                widget.hintTextStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kColorGrayT1,
                  fontStyle: FontStyle.normal,
                ),
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.borderColor ?? kColorGrayT1,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.borderColor ?? kColorGrayT1,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.borderColor ?? kColorGrayT1,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.borderColor ?? kColorGrayT1,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.borderColor ?? kColorGrayT1,
                width: 1,
              ),
            ),
            fillColor: widget.enabled ? kColorTransparent : kColorDesabled,
            filled: true,
            labelStyle:
                widget.hintTextStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kColorGrayT1,
                  fontStyle: FontStyle.normal,
                ),
            alignLabelWithHint: widget.alignLabelWithHint,
            error:
                widget.error!
                    ? Text(
                      widget.labelError ?? "-",
                      style:
                          widget.errorTextStyle ??
                          const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kColorRedT1,
                          ),
                    )
                    : null,
            floatingLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kColorGrayT1,
            ),
            labelText: widget.hasLabelText! ? widget.hintText : null,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: kColorPrimary,
            suffixIcon: widget.suffixIcon,
            prefix:
                widget.prefixIcon != null
                    ? SizedBox(width: widget.prefix)
                    : const SizedBox.shrink(),
            suffix:
                widget.suffixIcon != null
                    ? SizedBox(width: widget.suffix)
                    : const SizedBox.shrink(),
          ),
      style:
          widget.inputTextStyle ??
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color:
                context.watch<ThemeDataProvider>().darkMode
                    ? kColorTextDark
                    : kColorTextLight,
          ),
    );
  }
}
