import 'package:flutter/material.dart';
import 'package:look/constants/color_constants.dart';
import 'package:look/constants/size_constants.dart';

const kTextInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromRGBO(217, 217, 217, 1),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(217, 217, 217, 1)),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.dimen_10),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.dimen_10),
    ),
  ),
);

const Widget vertical5 = SizedBox(height: 5.0);
const Widget vertical10 = SizedBox(height: 10.0);
const Widget vertical15 = SizedBox(height: 15.0);
const Widget vertical20 = SizedBox(height: 20.0);

const Widget vertical25 = SizedBox(height: 25.0);
const Widget vertical30 = SizedBox(height: 30.0);

const Widget vertical50 = SizedBox(height: 50.0);
const Widget vertical120 = SizedBox(height: 120.0);
