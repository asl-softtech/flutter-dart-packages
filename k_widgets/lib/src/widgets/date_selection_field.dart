// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:solar_icons/solar_icons.dart';
//
// import '../../../../utils/extensions/extensions.dart';
// import 'text_input_field.dart';
//
// class KDateSelectionField extends StatefulWidget {
//   const KDateSelectionField({
//     super.key,
//     required this.title,
//     required this.onDateSelected,
//     this.pattern = "yyyy-MM-dd",
//     this.startDate,
//     this.endDate,
//     this.required = false,
//     this.showImmediately = false,
//   });
//
//   final String title, pattern;
//   final Function(DateTime) onDateSelected;
//   final DateTime? startDate, endDate;
//   final bool required;
//   final bool showImmediately;
//
//   @override
//   State<KDateSelectionField> createState() => KDateSelectionFieldState();
// }
//
// class KDateSelectionFieldState extends State<KDateSelectionField> {
//   late final DateFormat _format;
//
//   DateTime? _pickedDate;
//
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
//       _format = DateFormat(widget.pattern);
//       if (widget.showImmediately) {
//         _pickedDate = DateTime.now();
//         final dateText = _format.format(_pickedDate!);
//         _controller.text = dateText;
//         widget.onDateSelected(_pickedDate!);
//         setState(() {});
//       }
//     });
//   }
//
//   void clear() {
//     setState(() {
//       _pickedDate = null;
//       _controller.clear();
//     });
//   }
//
//   String? validate() {
//     if (widget.required && _pickedDate == null) {
//       return '${widget.title} is required';
//     }
//     return null;
//   }
//
//   void _datePicker() async {
//     final now = DateTime.now();
//     FocusScope.of(context).unfocus();
//
//     _pickedDate = await showDatePicker(
//       context: context,
//       firstDate: widget.startDate ?? DateTime(now.year - 5),
//       lastDate: widget.endDate ?? DateTime(now.year + 1, now.month + 1),
//     );
//     if (_pickedDate != null) {
//       final dateText = _format.format(_pickedDate!);
//       _controller.text = dateText;
//       widget.onDateSelected(_pickedDate!);
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mainWidget = KTextInputField(
//       controller: _controller,
//       title: widget.title,
//       enabled: false,
//       required: widget.required,
//       validator: (_) => validate(),
//       suffixIcon: Icon(
//         SolarIconsOutline.calendarDate,
//         size: 20,
//         color: context.theme.primaryColor,
//       ),
//     );
//     return InkWell(onTap: _datePicker, child: mainWidget);
//   }
// }
