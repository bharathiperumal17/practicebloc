import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key, required this.textController, required this.hintText});
  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).copyWith(bottom: 10, top: 10),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                gapPadding: 5, borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
