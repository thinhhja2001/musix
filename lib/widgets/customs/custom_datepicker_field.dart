import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/sign_up_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';

class CustomDatePickerField extends StatelessWidget {
  const CustomDatePickerField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    void _pickDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(2001),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: kPrimaryColor,
                        onPrimary: Colors.black,
                        onSurface: Colors.black)),
                child: child!);
          });
      signUpProvider.updateBirthDay(pickedDate);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromARGB(100, 49, 62, 85),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: InkWell(
            onTap: () => _pickDate(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    signUpProvider.birthDay == null
                        ? "Enter your birthday"
                        : DateFormat('d/M/y').format(signUpProvider.birthDay!),
                    style: signUpProvider.birthDay == null
                        ? kDefaultHintStyle
                        : kDefaultHintStyle.copyWith(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () => _pickDate(context),
                      icon:
                          const Icon(Icons.calendar_month, color: Colors.white))
                ],
              ),
            )),
      ),
    );
  }
}
