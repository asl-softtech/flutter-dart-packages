// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// import '../../../../utils/extensions/extensions.dart';
// import 'image_selection_field.dart';
//
// enum ImagePickSource { cameraS, galleryS }
//
// extension on ImagePickSource {
//   Source get source => switch (this) {
//     ImagePickSource.cameraS => Source.camera,
//     ImagePickSource.galleryS => Source.gallery,
//   };
// }
//
// class KMultiImageSelector extends StatefulWidget {
//   final int imageCount;
//   final String title;
//   final String initialName;
//   final List<ImagePickSource> sources;
//   final Function(File? image, int index) onImageSelected;
//
//   const KMultiImageSelector({
//     super.key,
//     this.imageCount = 2,
//     this.title = "Image",
//     this.initialName = "rmc_ss",
//     this.sources = ImagePickSource.values,
//     required this.onImageSelected,
//   }) : assert(
//   imageCount >= 2,
//   "Image count must be greater than or equal to 2",
//   );
//
//   @override
//   State<KMultiImageSelector> createState() => KMultiImageSelectorState();
// }
//
// class KMultiImageSelectorState extends State<KMultiImageSelector> {
//   late final List<GlobalKey<KImageSelectionFieldState>> _keys = List.generate(
//     widget.imageCount,
//         (index) => .new(),
//   );
//
//   void clear() {
//     for (var key in _keys) {
//       key.currentState?.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: widget.imageCount,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: context.isMobileScreen ? 2 : 4,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         childAspectRatio: 16 / 9,
//       ),
//       itemBuilder: (ctx, index) {
//         return KImageSelectionField(
//           key: _keys[index],
//           title: "${widget.title} ${index + 1}",
//           sources: widget.sources.map((e) => e.source).toList(),
//           fileNameMiddle: "${widget.initialName}_${index + 1}",
//           onImageSelected: (file) => widget.onImageSelected(file, index),
//         );
//       },
//     );
//   }
// }
