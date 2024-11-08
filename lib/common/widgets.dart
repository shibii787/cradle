import 'package:cradle/common/colors.dart';
import 'package:flutter/material.dart';

Widget getLateLoading(){
  return Container(
    color: AppColors.black,
    child: const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  );
}