import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';

class CustomDatePickerWidget extends StatelessWidget {
  final Function(DateTime?)? pickDateFunction;
  final String label;
  final DateTime? datePicker;
  final String? error;
  final bool darkTheme;
  const CustomDatePickerWidget({
    Key? key,
    required this.label,
    this.datePicker,
    this.pickDateFunction,
    this.error,
    this.darkTheme = true,
  }) : super(key: key);

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
                      primary: ColorTheme.primary,
                      onPrimary: Colors.black,
                      onSurface: Colors.black)),
              child: child!);
        });
    pickDateFunction?.call(pickedDate);
  }

  bool isError() {
    return error != null && error != '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 17,
              top: 4,
              bottom: 4,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isError() ? Colors.red : ColorTheme.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
                onTap: () => _pickDate(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      datePicker == null
                          ? label
                          : DateFormat('d MMM y').format(datePicker!),
                      style: datePicker == null
                          ? TextStyleTheme.ts15.copyWith(
                              color: darkTheme
                                  ? Colors.grey.shade100
                                  : Colors.black54,
                              fontWeight: FontWeight.w400,
                            )
                          : TextStyleTheme.ts15.copyWith(
                              color:
                                  darkTheme ? ColorTheme.white : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                    ),
                    IconButton(
                        onPressed: () => _pickDate(context),
                        icon: Icon(
                          Icons.calendar_month,
                          color: darkTheme ? Colors.white : Colors.black,
                        ))
                  ],
                )),
          ),
          if (isError()) ...[
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                error ?? '',
                style: TextStyleTheme.ts10.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
