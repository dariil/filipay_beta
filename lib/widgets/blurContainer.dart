import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlurContainer extends StatefulWidget {
  const BlurContainer({super.key});

  @override
  State<BlurContainer> createState() => _BlurContainerState();
}

class _BlurContainerState extends State<BlurContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset('assets/general/blur-container3.png')),
    );
  }
}
