// import 'package:flutter/material.dart';
// import '../../../../utils/extensions/extensions.dart';
// import '../../../../utils/theme/theme.dart';
//
// class KRadioField<K> extends StatelessWidget {
//   final List<K> items;
//   final String title;
//   final K? groupValue;
//   final List<K>? groupValues;
//   final ValueChanged<K?>? onValueChange;
//   final ValueChanged<List<K>>? onValuesChange;
//   final bool required;
//   final KRadioTile<K> Function(K)? tileBuilder;
//   final KCheckboxTile<K> Function(K)? checkboxTileBuilder;
//   final bool _isMultiSelect;
//
//   const KRadioField({
//     super.key,
//     required this.items,
//     required this.title,
//     this.groupValue,
//     required this.onValueChange,
//     this.required = false,
//     this.tileBuilder,
//   })  : _isMultiSelect = false,
//         groupValues = null,
//         onValuesChange = null,
//         checkboxTileBuilder = null;
//
//   const KRadioField.multiSelect({
//     super.key,
//     required this.items,
//     required this.title,
//     this.groupValues,
//     required this.onValuesChange,
//     this.required = false,
//     this.checkboxTileBuilder,
//   })  : _isMultiSelect = true,
//         groupValue = null,
//         onValueChange = null,
//         tileBuilder = null;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 4,
//           children: [
//             Text.rich(
//               TextSpan(
//                 text: title,
//                 children: [
//                   if (required)
//                     TextSpan(
//                       text: " *",
//                       style: context.text.bodySmall?.copyWith(color: redColor),
//                     ),
//                 ],
//               ),
//               style: context.text.bodySmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             if (_isMultiSelect)
//               _buildMultiSelect(context)
//             else
//               _buildSingleSelect(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSingleSelect(BuildContext context) {
//     return RadioGroup(
//       onChanged: onValueChange!,
//       groupValue: groupValue,
//       child: Wrap(
//         spacing: 4,
//         runSpacing: 4,
//         children: items
//             .map(
//               (e) => tileBuilder != null
//               ? tileBuilder!(e)
//               : KRadioTile(value: e, label: e.toString()),
//         )
//             .toList(),
//       ),
//     );
//   }
//
//   Widget _buildMultiSelect(BuildContext context) {
//     return Wrap(
//       spacing: 4,
//       runSpacing: 4,
//       children: items
//           .map(
//             (e) => checkboxTileBuilder != null
//             ? checkboxTileBuilder!(e)
//             : KCheckboxTile<K>(
//           value: e,
//           label: e.toString(),
//           isSelected: groupValues?.contains(e) ?? false,
//           onChanged: (selected) {
//             final currentValues = List<K>.from(groupValues ?? []);
//             if (selected) {
//               if (!currentValues.contains(e)) {
//                 currentValues.add(e);
//               }
//             } else {
//               currentValues.remove(e);
//             }
//             onValuesChange?.call(currentValues);
//           },
//         ),
//       )
//           .toList(),
//     );
//   }
// }
//
// class KRadioTile<K> extends StatelessWidget {
//   final K value;
//   final String label;
//
//   const KRadioTile({super.key, required this.value, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       spacing: 2,
//       children: [
//         Radio(
//           value: value,
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//         ),
//         Flexible(
//           child: Text(
//             label,
//             style: context.text.bodySmall?.copyWith(
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class KCheckboxTile<K> extends StatelessWidget {
//   final K value;
//   final String label;
//   final bool isSelected;
//   final ValueChanged<bool> onChanged;
//
//   const KCheckboxTile({
//     super.key,
//     required this.value,
//     required this.label,
//     required this.isSelected,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onChanged(!isSelected),
//       borderRadius: BorderRadius.circular(4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         spacing: 2,
//         children: [
//           Checkbox(
//             value: isSelected,
//             onChanged: (value) => onChanged(value ?? false),
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//           ),
//           Flexible(
//             child: Text(
//               label,
//               style: context.text.bodySmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }