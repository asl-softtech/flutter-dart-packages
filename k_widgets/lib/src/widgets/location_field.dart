// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../../../../utils/extensions/extensions.dart';
// import '../../../domain/entity/location.dart';
// import '../snack_bar/custom_snack_bar.dart';
// import 'text_input_field.dart';
//
// class KLocationField extends StatefulWidget {
//   final String title;
//   final bool required;
//   final bool getImmediately;
//   final ValueChanged<Location> onLocationFetched;
//
//   const KLocationField({
//     super.key,
//     required this.title,
//     this.required = false,
//     this.getImmediately = false,
//     required this.onLocationFetched,
//   });
//
//   @override
//   State<KLocationField> createState() => KLocationFieldState();
// }
//
// class KLocationFieldState extends State<KLocationField> {
//   final TextEditingController _controller = .new();
//   Location? _location;
//
//   void clear() {
//     setState(() {
//       _location = null;
//       _controller.clear();
//     });
//     widget.onLocationFetched(_location!);
//     if (widget.getImmediately) {
//       _fetchLocation();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
//       if (widget.getImmediately) {
//         await _fetchLocation();
//       }
//     });
//   }
//
//   Future<void> _fetchLocation() async {
//     try {
//       _controller.text = "Fetching location...";
//
//       // Check current permission status
//       LocationPermission permission = await Geolocator.checkPermission();
//
//       // Request permission if denied
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//
//       // Fetch location if we have permission
//       if (permission == LocationPermission.whileInUse ||
//           permission == LocationPermission.always) {
//         final geoLocation = await Geolocator.getCurrentPosition();
//
//         setState(() {
//           _location = Location.fromPosition(geoLocation);
//         });
//
//         _controller.text = "${_location!.latitude}, ${_location!.longitude}";
//         widget.onLocationFetched(_location!);
//       } else {
//         throw Exception("Location permission denied");
//       }
//     } catch (e) {
//       _controller.text = "";
//       if (mounted) {
//         context.showErrorSnackBar(e.toString());
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: _fetchLocation,
//       child: KTextInputField(
//         title: widget.title,
//         controller: _controller,
//         enabled: false,
//         readOnly: true,
//         required: widget.required,
//         suffixIcon: Icon(
//           Icons.location_on,
//           size: 20,
//           color: context.theme.primaryColor,
//         ),
//       ),
//     );
//   }
// }
