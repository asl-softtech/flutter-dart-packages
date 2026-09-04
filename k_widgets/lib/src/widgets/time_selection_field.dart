// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:solar_icons/solar_icons.dart';
//
// import '../../../../utils/extensions/extensions.dart';
// import 'text_input_field.dart';
//
// class KTimeSelectionField extends StatefulWidget {
//   const KTimeSelectionField({
//     super.key,
//     required this.title,
//     required this.onTimeSelected,
//     this.pattern = "HH : mm",
//     this.required = false,
//     this.showImmediately = false,
//   });
//
//   final String title, pattern;
//   final Function(TimeOfDay) onTimeSelected;
//   final bool required;
//   final bool showImmediately;
//
//   @override
//   State<KTimeSelectionField> createState() => KTimeSelectionFieldState();
// }
//
// class KTimeSelectionFieldState extends State<KTimeSelectionField> {
//   late final DateFormat _format;
//
//   TimeOfDay? _pickedTime;
//
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
//       _format = DateFormat(widget.pattern);
//       if (widget.showImmediately) {
//         _pickedTime = TimeOfDay.now();
//         final dateText = _format.format(_pickedTime!.toDateTime);
//         _controller.text = dateText;
//         widget.onTimeSelected(_pickedTime!);
//         setState(() {});
//       }
//     });
//   }
//
//   void clear() {
//     setState(() {
//       _pickedTime = null;
//       _controller.clear();
//     });
//   }
//
//   String? validate() {
//     if (widget.required && _pickedTime == null) {
//       return '${widget.title} is required';
//     }
//     return null;
//   }
//
//   void _datePicker() async {
//     FocusScope.of(context).unfocus();
//
//     _pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (_pickedTime != null) {
//       final dateText = _format.format(_pickedTime!.toDateTime);
//       _controller.text = dateText;
//       widget.onTimeSelected(_pickedTime!);
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
//         SolarIconsOutline.clockSquare,
//         size: 20,
//         color: context.theme.primaryColor,
//       ),
//     );
//     return InkWell(onTap: _datePicker, child: mainWidget);
//   }
// }
