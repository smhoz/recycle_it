import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';

class InputField extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final bool? isPassword;
  final TextInputType? textInputType;
  final String? prefix;
  final String? helperText;
  final double? borderRadius;
  final EdgeInsets? padding;
  final Function(String)? validator;
  final int? maxLength;
  TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? readOnly;

  InputField({
    Key? key,
    this.title,
    this.icon,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.prefix = "",
    this.helperText,
    this.borderRadius = 64,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
    this.validator,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.readOnly,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller ??= TextEditingController();
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius!),
      ),
      borderSide: BorderSide(color: context.theme.cardColor),
    );
    return Padding(
      padding: padding!,
      child: Stack(
        children: [
          Container(
            height: 60,
            width: context.width,
            decoration: _boxDecoration(),
          ),
          Form(
            key: formKey,
            child: Center(
              child: _textFormField(context, border),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _textFormField(
      BuildContext context, OutlineInputBorder border) {
    return TextFormField(
      onChanged: onChanged,
      maxLength: maxLength,
      readOnly: readOnly ?? false,
      controller: controller,
      obscureText: isPassword!,
      keyboardType: textInputType,
      validator: emptyValidator!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: _inputDecoration(context, border),
    );
  }

  InputDecoration _inputDecoration(
      BuildContext context, OutlineInputBorder border) {
    return InputDecoration(
      labelText: title,
      prefixIcon: icon,
      helperText: helperText,
      prefixText: prefix,
      filled: true,
      fillColor: context.theme.cardColor,
      prefixIconConstraints: const BoxConstraints(minWidth: 72),
      border: border,
      enabledBorder: border.copyWith(
          borderSide: BorderSide(color: context.theme.cardColor)),
      focusedBorder: border.copyWith(
        borderSide: BorderSide(
          color: context.themeColor.secondary,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius!),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: validatorShadowOffset,
        )
      ],
    );
  }
}

extension InputFieldExtension on InputField {
  String? Function(String?)? get emptyValidator => (value) {
        if (value!.isEmpty) {
          return "Bu alan boş bırakılamaz.";
        }
        return null;
      };
  Offset get validatorShadowOffset => const Offset(2, 4);
}
