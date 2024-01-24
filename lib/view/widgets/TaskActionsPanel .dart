import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomSlidePanel extends StatelessWidget {
  final Widget body;
  final Widget panel;
  final double minHeight;
  final double maxHeight;

  const CustomSlidePanel({super.key,
    required this.body,
    required this.panel,
    this.minHeight = 60.0,
    this.maxHeight = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: minHeight,
      maxHeight: maxHeight,
      body: body,
      panelBuilder: (ScrollController sc) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: panel
        );
      },
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      renderPanelSheet: false,
    );
  }

}


