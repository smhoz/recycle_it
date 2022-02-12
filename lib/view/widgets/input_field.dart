import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';

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

  InputField(
      {Key? key,
      this.title,
      this.icon,
      this.isPassword = false,
      this.textInputType = TextInputType.text,
      this.borderRadius = 64,
      this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      this.prefix = "",
      this.helperText,
      this.validator,
      this.maxLength})
      : super(key: key);

  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: validatorShadowOffset,
                )
              ],
            ),
          ),
          Form(
            key: formKey,
            child: TextFormField(
              maxLength: maxLength,
              controller: controller,
              obscureText: isPassword!,
              keyboardType: textInputType,
              validator: emptyValidator!,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
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
              ),
            ),
          ),
        ],
      ),
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
