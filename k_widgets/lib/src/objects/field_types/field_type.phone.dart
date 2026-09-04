part of 'field_type.dart';

final class PhoneField extends FieldType {
  final List<Countries> _listOfAllowedCountries;

  PhoneField({List<Countries> listOfAllowedCountries = allCountries})
    : _listOfAllowedCountries = listOfAllowedCountries;

  @override
  // TODO: implement definedInputFormatters
  List<TextInputFormatter>? get definedInputFormatters =>
      throw UnimplementedError();

  @override
  int get definedMaxLength => 10;

  @override
  int? get definedMaxLines => 1;

  @override
  TextCapitalization get definedTextCapitalization =>
      TextCapitalization.none;

  @override
  TextInputType get definedTextInputType => TextInputType.phone;

  @override
  // TODO: implement definedValidator
  FormFieldValidator<String>? get definedValidator =>
      throw UnimplementedError();
}
