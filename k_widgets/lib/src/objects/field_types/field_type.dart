import 'package:flutter/material.dart'
    show TextInputType, FormFieldValidator, TextCapitalization;
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:k_widgets/src/objects/countries/countries.dart';

part 'field_type.mail.dart';

part 'field_type.phone.dart';

sealed class FieldType {
  const FieldType();

  FormFieldValidator<String>? get definedValidator;

  List<TextInputFormatter>? get definedInputFormatters;

  int get definedMaxLength;

  int? get definedMaxLines;

  TextCapitalization get definedTextCapitalization;

  TextInputType get definedTextInputType;
}
