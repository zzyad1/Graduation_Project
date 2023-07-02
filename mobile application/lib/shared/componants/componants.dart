import 'package:flutter/material.dart';

import '../../modules/profile/Edit_profile.dart';

Widget defaultButton({
  double width= double.infinity ,
  Color backgraound = Colors.blue ,
  bool isUpperCase = true,
  required void Function() function,
  required String text,
}) => Container(
  width: width,
  color: backgraound,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
          color: Colors.white),
    ),
  ),
);

