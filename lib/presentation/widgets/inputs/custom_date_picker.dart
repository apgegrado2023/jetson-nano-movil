import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImputDatePicker extends StatefulWidget {
  final void Function(DateTime)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(DateTime?)? validator;

  const CustomImputDatePicker({
    Key? key,
    this.onChanged,
    required this.label,
    this.inputType,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomImputDatePicker> createState() => _CustomImputDatePickerState();
}

class _CustomImputDatePickerState extends State<CustomImputDatePicker> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        final DateTime? value = state.value;
        final bool hasError = state.hasError;

        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 48,
                child: TextField(
                  controller: null,
                  obscureText: _obscureText,
                  keyboardType: widget.inputType,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        right: 0, left: 10, top: 8.0, bottom: 8.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.black,
                    ),
                    hintText: widget.label,
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    showDatePicker(
                      context: context,
                      locale: const Locale("es", "ES"),
                      initialDate: value ?? DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2222),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        state.didChange(selectedDate);
                        if (widget.validator != null) {
                          state.validate();
                        }
                        if (widget.onChanged != null) {
                          log(selectedDate.toString());
                          widget.onChanged!(selectedDate);
                        }
                      }
                    }).ignore();
                  },
                ),
              ),
              if (hasError)
                Text(
                  state.errorText!,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 194, 18, 18)),
                ),
            ],
          ),
        );
      },
    );
  }
}
