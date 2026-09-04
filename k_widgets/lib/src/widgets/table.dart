// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../feature/settings/data/model/theme_profile/theme_model.dart';
// import '../../../../../feature/settings/presentation/bloc/theme/theme_bloc.dart';
// import '../../../../utils/extensions/extensions.dart';
//
// class KTable extends StatelessWidget {
//   final List<String> headers;
//   final List<List<String>> rows;
//   final List<String>? footerRow;
//   final String emptyMessage;
//   final Function(int index)? onRowTap;
//
//   const KTable({
//     super.key,
//     required this.headers,
//     required this.rows,
//     this.footerRow,
//     this.emptyMessage = "No Data Found",
//     this.onRowTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final headerColor = context.theme.primaryColor;
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildHeader(headerColor),
//           if (rows.isEmpty) _emptyView(context),
//           ...rows.asMap().entries.map(
//                 (entry) => _buildRow(entry.value, entry.key),
//           ),
//           if (footerRow != null) _buildFooterRow(context),
//         ],
//       ),
//     );
//   }
//
//   Widget _emptyView(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         color: context.watch<ThemeBloc>().state.theme.isDark
//             ? Colors.black
//             : Colors.white,
//         borderRadius: footerRow == null
//             ? const BorderRadius.vertical(bottom: Radius.circular(8))
//             : null,
//       ),
//       child: Center(child: Text(emptyMessage)),
//     );
//   }
//
//   Widget _buildHeader(Color headerColor) {
//     return Container(
//       decoration: BoxDecoration(
//         color: headerColor,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           ...headers.map(
//                 (h) => Expanded(
//               child: Center(
//                 child: Text(
//                   h,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRow(List<String> row, int index) {
//     return InkWell(
//       onTap: onRowTap != null ? () => onRowTap!(index) : null,
//       child: Container(
//         decoration: const BoxDecoration(
//           border: Border(top: BorderSide(color: Colors.grey)),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         child: Row(
//           children: row
//               .map((cell) => Expanded(child: Center(child: Text(cell))))
//               .toList(),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFooterRow(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(color: context.theme.primaryColor, width: 1.5),
//         ),
//         borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 14),
//       child: Row(
//         children: footerRow!
//             .map(
//               (cell) => Expanded(
//             child: Center(
//               child: Text(
//                 cell,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ),
//         )
//             .toList(),
//       ),
//     );
//   }
// }
