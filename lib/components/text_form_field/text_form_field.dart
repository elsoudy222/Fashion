import 'package:flutter/material.dart';

import '../../view/const/fonts.dart';

class TextFieldAddress extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;

  const TextFieldAddress({
    Key? key,
    required this.textEditingController,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(1, 1),
            ),
          ]),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          alignLabelWithHint: true, // center labastyle
          labelStyle: AppFont.regular.copyWith(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


