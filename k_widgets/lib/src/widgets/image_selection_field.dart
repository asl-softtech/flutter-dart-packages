// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:media_compressor/media_compressor.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
// import 'package:solar_icons/solar_icons.dart';
//
// import '../../../../utils/constants/app_constants.dart';
// import '../../../../utils/extensions/extensions.dart';
// import '../../../../utils/logger/pretty_logger.dart';
// import '../../../../utils/theme/theme.dart';
// import '../buttons/basic_elevated_btn.dart';
// import '../container/primary_container.dart';
// import '../snack_bar/custom_snack_bar.dart';
//
// enum Source { camera, gallery }
//
// class KImageSelectionField extends StatefulWidget {
//   final String title;
//   final bool required;
//   final List<Source> sources;
//   final ValueChanged<File?> onImageSelected;
//   final String fileNameMiddle;
//   final double? width;
//
//   const KImageSelectionField({
//     super.key,
//     required this.title,
//     this.required = false,
//     this.sources = Source.values,
//     required this.onImageSelected,
//     this.fileNameMiddle = "rmc_ss",
//     this.width,
//   });
//
//   @override
//   State<KImageSelectionField> createState() => KImageSelectionFieldState();
// }
//
// class KImageSelectionFieldState extends State<KImageSelectionField> {
//   File? _selectedImage;
//   bool _isValidate = true;
//
//   bool get valid {
//     final validate = widget.required ? _selectedImage != null : true;
//     setState(() {
//       _isValidate = validate;
//     });
//     return validate;
//   }
//
//   void clear() {
//     setState(() {
//       _selectedImage = null;
//       _isValidate = true;
//     });
//   }
//
//   Future<void> _pickImage(Source source) async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: source.toImageSource);
//       if (pickedFile == null) return;
//
//       final compressionResult = await MediaCompressor.compressImage(
//         ImageCompressionConfig(path: pickedFile.path, quality: 40),
//       );
//
//       if (compressionResult.isFailure) {
//         throw Exception(compressionResult.error!.message);
//       }
//
//       final originalFile = File(compressionResult.path!);
//       final timestamp = DateTime.now().toIso8601String().replaceAll(
//         RegExp(r'[:.-]'),
//         '',
//       );
//       final newFileName = 'img_${widget.fileNameMiddle}_$timestamp.png';
//
//       final appDir = await getApplicationDocumentsDirectory();
//       final targetDir = Directory(
//         p.join(appDir.path, '${appName.toSnackCase}_images'.lowerCase),
//       );
//
//       if (!await targetDir.exists()) {
//         await targetDir.create(recursive: true);
//       }
//
//       final newFile = await originalFile.copy(
//         p.join(targetDir.path, newFileName),
//       );
//
//       setState(() {
//         _selectedImage = newFile;
//         valid;
//       });
//       widget.onImageSelected.call(newFile);
//     } catch (e, s) {
//       pLog.e(e.toString(), stackTrace: s);
//       if (mounted) {
//         context.showErrorSnackBar(e.toString());
//       }
//     }
//   }
//
//   void _handleImageSelected() {
//     if (widget.sources.isEmpty) {
//       context.showErrorSnackBar("No image sources available");
//       return;
//     }
//
//     if (widget.sources.length == 1) {
//       _pickImage(widget.sources.first);
//       return;
//     } else {
//       _dialog(context, (source) => _pickImage(source));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final boxWidth = widget.width ?? context.width;
//     return SizedBox(
//       width: boxWidth,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 8,
//         children: [
//           AspectRatio(
//             aspectRatio: 16 / 9,
//             child: PrimaryContainer(
//               onClick: _handleImageSelected,
//               width: context.width,
//               showShadow: false,
//               color: context.theme.cardColor,
//               child: Stack(
//                 children: [
//                   if (_selectedImage != null)
//                     Center(
//                       child: AspectRatio(
//                         aspectRatio: 16 / 9,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.file(_selectedImage!, fit: BoxFit.cover),
//                         ),
//                       ),
//                     )
//                   else
//                     Center(
//                       child: Icon(
//                         SolarIconsOutline.cameraAdd,
//                         size: 40,
//                         color: context.theme.primaryColor,
//                       ),
//                     ),
//
//                   if (_selectedImage != null)
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 8,
//                         ),
//                         child: Text(
//                           _selectedImage!.name,
//                           style: context.text.labelMedium,
//                         ),
//                       ),
//                     ),
//
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       constraints: BoxConstraints(maxWidth: boxWidth * 0.80),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 8,
//                       ).copyWith(right: 40),
//                       decoration: BoxDecoration(
//                         color: context.theme.primaryColor,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(8),
//                           bottomRight: Radius.circular(50),
//                         ),
//                       ),
//                       child: Text(
//                         "${widget.title}${widget.required ? ' *' : ''}",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: context.text.bodyMedium?.copyWith(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (!_isValidate)
//             Text(
//               "Please select an image",
//               style: context.text.bodySmall?.copyWith(color: redColor),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _dialog(BuildContext context, Function(Source) onSelect) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Choose Image Source"),
//         titleTextStyle: context.text.headlineMedium?.copyWith(
//           color: context.theme.primaryColor,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadiusGeometry.circular(8),
//         ),
//         content: Row(
//           spacing: 12,
//           children: [
//             _DialogImageButton(
//               iconData: SolarIconsOutline.camera,
//               onPress: () {
//                 Navigator.pop(context);
//                 onSelect(Source.camera);
//               },
//             ),
//             _DialogImageButton(
//               iconData: SolarIconsOutline.gallery,
//               onPress: () {
//                 Navigator.pop(context);
//                 onSelect(Source.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _DialogImageButton extends StatelessWidget {
//   final IconData iconData;
//   final VoidCallback onPress;
//
//   const _DialogImageButton({required this.iconData, required this.onPress});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BasicElevatedBtn(
//         onTap: onPress,
//         bgColor: kPrimaryColor,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(iconData, color: Colors.white, size: 48),
//         ),
//       ).elevate,
//     );
//   }
// }
//
// extension on Source {
//   ImageSource get toImageSource => switch (this) {
//     Source.camera => ImageSource.camera,
//     Source.gallery => ImageSource.gallery,
//   };
// }
