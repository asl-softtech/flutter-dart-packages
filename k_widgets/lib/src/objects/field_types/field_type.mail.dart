part of 'field_type.dart';

final class MailField extends FieldType {
  final int _maxLength;

  const MailField({int maxLength = 320}) : _maxLength = maxLength;

  @override
  List<TextInputFormatter>? get definedInputFormatters => null;

  @override
  int get definedMaxLength => _maxLength;

  @override
  int? get definedMaxLines => null;

  @override
  TextCapitalization get definedTextCapitalization => TextCapitalization.none;

  @override
  TextInputType get definedTextInputType => TextInputType.emailAddress;

  @override
  FormFieldValidator<String>? get definedValidator => (value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  };
}
