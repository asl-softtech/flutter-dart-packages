// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show TextInputFormatter;
//
// import '../../../../utils/extensions/extensions.dart';
// import '../../../../utils/theme/theme.dart';
// import '../../../domain/enum/field_type/field_type.dart';
//
// class KTextInputField extends StatefulWidget {
//   final String title;
//   final bool enabled;
//   final String? initialText;
//   final TextEditingController? controller;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//   final TextAlign textAlign;
//   final FieldType fieldType;
//   final bool required;
//   final int? maxLength;
//   final FocusNode? focusNode;
//   final FloatingLabelBehavior floatingLabelBehavior;
//   final void Function(String)? onSubmit;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool obscureText;
//   final int? maxLines;
//   final bool readOnly;
//   final TextInputAction? textInputAction;
//
//   const KTextInputField({
//     super.key,
//     required this.title,
//     this.enabled = true,
//     this.required = false,
//     this.validator,
//     this.onChanged,
//     this.textAlign = TextAlign.start,
//     this.fieldType = FieldType.normal,
//     this.controller,
//     this.initialText,
//     this.maxLength,
//     this.focusNode,
//     this.floatingLabelBehavior = FloatingLabelBehavior.auto,
//     this.onSubmit,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.obscureText = false,
//     this.maxLines,
//     this.readOnly = false,
//     this.textInputAction,
//   });
//
//   @override
//   State<KTextInputField> createState() => _KTextInputFieldState();
// }
//
// class _KTextInputFieldState extends State<KTextInputField> {
//   late FocusNode _focusNode;
//   TextEditingController? _internalController;
//   bool _initialized = false;
//
//   TextEditingController get _effectiveController =>
//       widget.controller ?? _internalController!;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = widget.focusNode ?? FocusNode();
//     if (widget.controller == null) {
//       _internalController = TextEditingController();
//     }
//   }
//
//   @override
//   void dispose() {
//     _internalController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didUpdateWidget(covariant KTextInputField oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.controller == null && oldWidget.controller != null) {
//       _internalController = TextEditingController();
//     } else if (widget.controller != null && oldWidget.controller == null) {
//       _internalController?.dispose();
//       _internalController = null;
//     }
//     if (widget.initialText != oldWidget.initialText) {
//       _initialized = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // One-time initialization of controller text
//     // One-time initialization of controller text
//     if (!_initialized && widget.initialText != null) {
//       _effectiveController.text = widget.initialText!;
//       _initialized = true;
//     }
//
//     // Determine maxLength for phone field
//     final maxLength = widget.maxLength ?? widget.fieldType.maxLength;
//     var maxLines = widget.maxLines ?? widget.fieldType.maxLines;
//     if (widget.obscureText) {
//       maxLines = 1;
//     }
//     return TextFormField(
//       focusNode: _focusNode,
//       controller: _effectiveController,
//       enabled: widget.enabled,
//       readOnly: widget.readOnly,
//       maxLines: maxLines,
//       validator:
//       widget.validator ??
//               (value) {
//             if (widget.required && (value == null || value.trim().isEmpty)) {
//               return '${widget.title} is required';
//             }
//             if (value != null && value.trim().isNotEmpty) {
//               return widget.fieldType.defaultValidation?.call(value);
//             }
//             return null;
//           },
//       style: context.text.bodyMedium,
//       cursorColor: context.theme.primaryColor,
//       onChanged: (value) {
//         // Handle phone number formatting on change
//         if (widget.fieldType == FieldType.phone) {
//           final formattedValue = _formatPhoneNumber(value);
//           if (formattedValue != value) {
//             // final selection = widget.controller!.selection;
//             _effectiveController.text = formattedValue;
//             // Maintain cursor position
//             _effectiveController.selection = TextSelection.fromPosition(
//               TextPosition(offset: formattedValue.length),
//             );
//           }
//           widget.onChanged?.call(formattedValue);
//         } else {
//           widget.onChanged?.call(value);
//         }
//
//         // Unfocus when maxLength is reached (e.g., phone field)
//         if (value.length == maxLength) {
//           widget.onSubmit != null
//               ? widget.onSubmit!.call(value)
//               : _focusNode.unfocus();
//         }
//       },
//       onFieldSubmitted: widget.onSubmit ?? (_) => _focusNode.unfocus(),
//       // Unfocus on "Done"
//       textInputAction: widget.textInputAction ?? TextInputAction.done,
//       textAlign: widget.textAlign,
//       textAlignVertical: TextAlignVertical.top,
//       keyboardType: widget.fieldType.keyboardType,
//       inputFormatters: _getInputFormatters(),
//       textCapitalization: widget.fieldType.textCapitalization,
//       maxLength: maxLength,
//       obscureText: widget.obscureText,
//       decoration: InputDecoration(
//         labelText: "${widget.title}${widget.required ? ' *' : ''}",
//         alignLabelWithHint: true,
//         filled: true,
//         fillColor: Theme.of(context).primaryColor.withValues(alpha: 0.05),
//         floatingLabelBehavior: widget.floatingLabelBehavior,
//         labelStyle: Theme.of(
//           context,
//         ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
//         floatingLabelStyle: Theme.of(
//           context,
//         ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor),
//         errorStyle: Theme.of(
//           context,
//         ).textTheme.bodySmall?.copyWith(color: redColor),
//         border: _border(Theme.of(context).primaryColor),
//         // disabledBorder: _border(Theme.of(context).primaryColor),
//         focusedBorder: _border(Theme.of(context).primaryColor),
//         errorBorder: _border(redColor),
//         focusedErrorBorder: _border(redColor),
//         counter: const SizedBox.shrink(),
//         suffixIcon: widget.suffixIcon,
//         prefixIcon: widget.prefixIcon,
//       ),
//     );
//   }
//
//   List<TextInputFormatter> _getInputFormatters() {
//     if (widget.fieldType == FieldType.phone) {
//       return [
//         PhoneNumberInputFormatter(),
//         ...?widget.fieldType.inputFormatters,
//       ];
//     }
//     return widget.fieldType.inputFormatters ?? [];
//   }
//
//   String _formatPhoneNumber(String input) {
//     if (widget.fieldType != FieldType.phone) return input;
//
//     // Extract only digits from input
//     String digitsOnly = input.replaceAll(RegExp(r'\D'), '');
//
//     // If more than 11 digits, take the last 11
//     if (digitsOnly.length > 11) {
//       digitsOnly = digitsOnly.substring(digitsOnly.length - 11);
//     }
//
//     // Ensure it starts with 0 for Bangladeshi numbers
//     if (digitsOnly.isNotEmpty && !digitsOnly.startsWith('0')) {
//       // If it's an 11-digit number starting with 1, prepend 0
//       if (digitsOnly.length == 11 && digitsOnly.startsWith('1')) {
//         digitsOnly = '0$digitsOnly';
//         digitsOnly = digitsOnly.substring(0, 11); // Keep only 11 digits
//       } else if (digitsOnly.length <= 10) {
//         digitsOnly = '0$digitsOnly';
//       }
//     }
//
//     return digitsOnly;
//   }
//
//   OutlineInputBorder _border(Color color) {
//     return OutlineInputBorder(
//       borderSide: BorderSide(color: color, width: 1),
//       borderRadius: BorderRadius.circular(8),
//     );
//   }
// }
