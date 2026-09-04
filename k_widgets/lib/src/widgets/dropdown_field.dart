// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../feature/settings/data/model/theme_profile/theme_model.dart';
// import '../../../../../feature/settings/presentation/bloc/theme/theme_bloc.dart';
// import '../../../../utils/extensions/extensions.dart';
// import '../../../../utils/theme/theme.dart';
// import '../../../domain/enum/dropdown_popup_type/dropdown_popup_type.dart';
//
// class KDropdownField<k> extends StatefulWidget {
//   final String title;
//   final List<k> values;
//   final String? hint;
//   final k? selectedValue;
//   final List<k>? selectedValues;
//   final ValueChanged<k>? onChange;
//   final ValueChanged<List<k>>? onChangeMulti;
//   final bool required;
//   final bool showSearch;
//   final DropdownPopupType popupType;
//   final bool enabled;
//   final FormFieldValidator<k>? validator;
//   final FormFieldValidator<List<k>>? validatorMulti;
//   final FloatingLabelBehavior floatingLabelBehavior;
//   final String Function(k)? itemAsString;
//   final bool Function(k, k)? compareFn;
//   final bool _isMultiSelect;
//   final Widget Function(BuildContext, List<k>)? dropdownBuilder;
//   final Widget Function(BuildContext, k, bool, bool)? checkBoxBuilder;
//
//   const KDropdownField({
//     super.key,
//     required this.title,
//     required this.values,
//     required this.onChange,
//     this.hint,
//     this.selectedValue,
//     this.required = false,
//     this.showSearch = true,
//     this.popupType = DropdownPopupType.menu,
//     this.enabled = true,
//     this.validator,
//     this.floatingLabelBehavior = FloatingLabelBehavior.auto,
//     this.itemAsString,
//     this.compareFn,
//   }) : _isMultiSelect = false,
//         selectedValues = null,
//         onChangeMulti = null,
//         validatorMulti = null,
//         dropdownBuilder = null,
//         checkBoxBuilder = null,
//         assert(
//         k == String || k == int || k == double || compareFn != null,
//         '`compareFn` is required',
//         );
//
//   const KDropdownField.multiSelect({
//     super.key,
//     required this.title,
//     required this.values,
//     required this.onChangeMulti,
//     this.hint,
//     this.selectedValues,
//     this.required = false,
//     this.showSearch = true,
//     this.popupType = DropdownPopupType.menu,
//     this.enabled = true,
//     this.validatorMulti,
//     this.floatingLabelBehavior = FloatingLabelBehavior.auto,
//     this.itemAsString,
//     this.dropdownBuilder,
//     this.compareFn,
//     this.checkBoxBuilder,
//   }) : _isMultiSelect = true,
//         selectedValue = null,
//         onChange = null,
//         validator = null,
//         assert(
//         k == String || k == int || k == double || compareFn != null,
//         '`compareFn` is required',
//         );
//
//   @override
//   State<KDropdownField<k>> createState() => KDropdownFieldState<k>();
// }
//
// class KDropdownFieldState<k> extends State<KDropdownField<k>> {
//   final _key = GlobalKey<DropdownSearchState<k>>();
//
//   void clear() => _key.currentState?.clear();
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget._isMultiSelect) {
//       return _buildMultiSelectDropdown(context);
//     }
//     return _buildSingleSelectDropdown(context);
//   }
//
//   Widget _buildSingleSelectDropdown(BuildContext context) {
//     return DropdownSearch<k>(
//       key: _key,
//       enabled: widget.enabled,
//       items: (f, s) => widget.values,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       compareFn: widget.compareFn,
//       selectedItem: widget.selectedValue,
//       itemAsString: widget.itemAsString,
//       decoratorProps: _buildDropDownDecoratorProps(context),
//       suffixProps: DropdownSuffixProps(
//         dropdownButtonProps: DropdownButtonProps(
//           color: context.theme.primaryColor,
//         ),
//       ),
//       onChanged: (value) {
//         FocusScope.of(context).unfocus();
//         if (value != null) widget.onChange?.call(value);
//       },
//       validator:
//       widget.validator ??
//               (value) {
//             if (widget.required && value == null) {
//               return '${widget.title} is required';
//             }
//             return null;
//           },
//       popupProps: switch (widget.popupType) {
//         DropdownPopupType.model => _buildModelPopupProps(context),
//         DropdownPopupType.dialog => _buildDialogPopupProps(context),
//         DropdownPopupType.menu => _buildMenuPopupProps(context),
//       },
//     );
//   }
//
//   Widget _buildMultiSelectDropdown(BuildContext context) {
//     return DropdownSearch<k>.multiSelection(
//       key: _key,
//       enabled: widget.enabled,
//       items: (f, s) => widget.values,
//       compareFn: widget.compareFn,
//       selectedItems: widget.selectedValues ?? [],
//       itemAsString: widget.itemAsString,
//       dropdownBuilder: widget.dropdownBuilder,
//       decoratorProps: _buildDropDownDecoratorProps(context),
//       suffixProps: DropdownSuffixProps(
//         dropdownButtonProps: DropdownButtonProps(
//           color: context.theme.primaryColor,
//         ),
//       ),
//       onChanged: (value) {
//         FocusScope.of(context).unfocus();
//         if (value.isNotEmpty) widget.onChangeMulti?.call(value);
//       },
//       validator:
//       widget.validatorMulti ??
//               (value) {
//             if (widget.required && value == null) {
//               return '${widget.title} is required';
//             }
//             return null;
//           },
//       popupProps: switch (widget.popupType) {
//         DropdownPopupType.model => _buildModelMultiPopupProps(context),
//         DropdownPopupType.dialog => _buildDialogMultiPopupProps(context),
//         DropdownPopupType.menu => _buildMenuMultiPopupProps(context),
//       },
//     );
//   }
//
//   // Single Select Popup Props
//   PopupProps<k> _buildDialogPopupProps(BuildContext context) {
//     return PopupProps.dialog(
//       fit: FlexFit.loose,
//       dialogProps: const DialogProps(barrierDismissible: true),
//       showSearchBox: widget.showSearch,
//       searchFieldProps: _searchFieldProps(context),
//     );
//   }
//
//   PopupProps<k> _buildMenuPopupProps(BuildContext context) {
//     return PopupProps.menu(
//       fit: FlexFit.loose,
//       menuProps: MenuProps(
//         backgroundColor: context.watch<ThemeBloc>().state.theme.isDark
//             ? Colors.black
//             : Colors.white,
//         barrierDismissible: true,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       showSearchBox: widget.showSearch,
//       searchFieldProps: _searchFieldProps(context),
//     );
//   }
//
//   PopupProps<k> _buildModelPopupProps(BuildContext context) {
//     return PopupProps.modalBottomSheet(
//       modalBottomSheetProps: const ModalBottomSheetProps(
//         useSafeArea: true,
//         padding: EdgeInsets.all(12),
//         barrierDismissible: true,
//       ),
//       showSearchBox: widget.showSearch,
//       searchFieldProps: _searchFieldProps(context),
//     );
//   }
//
//   // Multi Select Popup Props
//   PopupPropsMultiSelection<k> _buildDialogMultiPopupProps(
//       BuildContext context,
//       ) {
//     return PopupPropsMultiSelection.dialog(
//       fit: FlexFit.loose,
//       dialogProps: const DialogProps(barrierDismissible: true),
//       showSearchBox: widget.showSearch,
//       checkBoxBuilder: widget.checkBoxBuilder,
//       searchFieldProps: _searchFieldProps(context),
//     );
//   }
//
//   PopupPropsMultiSelection<k> _buildMenuMultiPopupProps(BuildContext context) {
//     return PopupPropsMultiSelection.menu(
//       fit: FlexFit.loose,
//       menuProps: MenuProps(
//         backgroundColor: context.watch<ThemeBloc>().state.theme.isDark
//             ? Colors.black
//             : Colors.white,
//         barrierDismissible: true,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       showSearchBox: widget.showSearch,
//       checkBoxBuilder: widget.checkBoxBuilder,
//       searchFieldProps: _searchFieldProps(context),
//     );
//   }
//
//   PopupPropsMultiSelection<k> _buildModelMultiPopupProps(BuildContext context) {
//     return PopupPropsMultiSelection.modalBottomSheet(
//       modalBottomSheetProps: const ModalBottomSheetProps(
//         useSafeArea: true,
//         padding: EdgeInsets.all(12),
//         barrierDismissible: true,
//       ),
//       checkBoxBuilder: widget.checkBoxBuilder,
//       showSearchBox: widget.showSearch,
//       searchFieldProps: _searchFieldProps(context),
//     );
//   }
//
//   // Shared Methods
//   DropDownDecoratorProps _buildDropDownDecoratorProps(BuildContext context) {
//     return DropDownDecoratorProps(
//       decoration: InputDecoration(
//         labelText: "${widget.title}${widget.required ? ' *' : ''}",
//         filled: true,
//         // fillColor: context.theme.primaryColor.withValues(alpha: 0.05),
//         floatingLabelBehavior: widget.floatingLabelBehavior,
//         // labelStyle: context.text.bodyMedium?.copyWith(color: Colors.blueGrey),
//         // floatingLabelStyle: context.text.bodyMedium?.copyWith(
//         //   color: context.theme.primaryColor,
//         // ),
//         // errorStyle: context.text.bodySmall?.copyWith(color: redColor),
//         // border: _border(context.theme.primaryColor),
//         // focusedBorder: _border(context.theme.primaryColor),
//         // errorBorder: _border(redColor),
//         // focusedErrorBorder: _border(redColor),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       ),
//     );
//   }
//
//   TextFieldProps _searchFieldProps(BuildContext context) {
//     return TextFieldProps(
//       decoration: InputDecoration(
//         filled: true,
//         hintText: "Search",
//         contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
//         // fillColor: context.theme.primaryColor.withValues(alpha: 0.05),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           // borderSide: BorderSide(color: context.theme.primaryColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           // borderSide: BorderSide(color: context.theme.primaryColor),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           // borderSide: BorderSide(color: context.theme.primaryColor),
//         ),
//       ),
//     );
//   }
//
//   OutlineInputBorder _border(Color color) {
//     return OutlineInputBorder(
//       borderSide: BorderSide(color: color, width: 1),
//       borderRadius: BorderRadius.circular(8),
//     );
//   }
// }
