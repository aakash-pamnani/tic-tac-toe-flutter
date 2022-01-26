import 'package:flutter/material.dart';

extension CustomButtonStyle on ButtonStyle {
  get mediumSize => copyWith(
      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(100)));
}

extension CutstomTextStyle on TextStyle {
  get mediumSize => copyWith(fontSize: 18);

  get boldText => copyWith(fontWeight: FontWeight.bold);
}
