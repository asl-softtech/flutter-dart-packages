import 'package:flutter/material.dart';

class KColumnSections extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  const KColumnSections({
    super.key,
    this.title,
    required this.children,
    this.spacing = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Container(
            // width: context.width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // decoration: BoxDecoration(color: context.theme.primaryColor),
            child: Text(
              title!,
              // style: context.text.bodyLarge?.copyWith(
                // color: context.theme.colorScheme.onPrimary,
              // ),
            ),
          ),
        Padding(
          padding:
          padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(spacing: spacing, children: children),
        ),
      ],
    );
  }
}
