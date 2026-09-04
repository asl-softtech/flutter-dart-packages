// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:solar_icons/solar_icons.dart';
//
// import '../../../../utils/extensions/extensions.dart';
// import 'text_input_field.dart';
//
// class KDatetimeSelectionField extends StatefulWidget {
//   const KDatetimeSelectionField({
//     super.key,
//     required this.title,
//     required this.onDateSelected,
//     this.pattern = "yyyy-MM-dd HH:mm",
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
//   State<KDatetimeSelectionField> createState() =>
//       KDatetimeSelectionFieldState();
// }
//
// class KDatetimeSelectionFieldState extends State<KDatetimeSelectionField> {
//   late final DateFormat _format;
//
//   DateTime? _pickedDateTime;
//
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
//       _format = DateFormat(widget.pattern);
//       if (widget.showImmediately) {
//         _pickedDateTime = DateTime.now();
//         final dateText = _format.format(_pickedDateTime!);
//         _controller.text = dateText;
//         widget.onDateSelected(_pickedDateTime!);
//         setState(() {});
//       }
//     });
//   }
//
//   void clear() {
//     setState(() {
//       _pickedDateTime = null;
//       _controller.clear();
//     });
//   }
//
//   String? validate() {
//     if (widget.required && _pickedDateTime == null) {
//       return '${widget.title} is required';
//     }
//     return null;
//   }
//
//   Future<void> _datetimePicker() async {
//     final now = DateTime.now();
//     FocusScope.of(context).unfocus();
//
//     // Pick date
//     final date = await showDatePicker(
//       context: context,
//       firstDate: widget.startDate ?? DateTime(now.year - 5),
//       lastDate: widget.endDate ?? DateTime(now.year, now.month + 1),
//     );
//
//     // Early return if date picker cancelled
//     if (date == null) return;
//
//     // Pick time
//     if (!mounted) return;
//
//     final timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     // Early return if time picker cancelled
//     if (timeOfDay == null) return;
//
//     // Combine date and time
//     _pickedDateTime = DateTime(
//       date.year,
//       date.month,
//       date.day,
//       timeOfDay.hour,
//       timeOfDay.minute,
//     );
//
//     // Update UI
//     _controller.text = _format.format(_pickedDateTime!);
//     widget.onDateSelected(_pickedDateTime!);
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
//         SolarIconsOutline.sortByTime,
//         size: 20,
//         color: context.theme.primaryColor,
//       ),
//     );
//     return InkWell(onTap: _datetimePicker, child: mainWidget);
//   }
// }
