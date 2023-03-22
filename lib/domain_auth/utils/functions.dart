import 'package:flutter/material.dart';

bool isNumericString(String s) {
  for (var c in s.characters) {
    if (int.tryParse(c) == null) return false;
  }
  return true;
}
