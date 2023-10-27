import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomInputFieldBloc extends StatefulWidget {
  final void Function(String)? onChanged;
  final Stream<String>? stream;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final Icon? icon;
  final bool isNoSpace;
  final String? initialValue;
  final bool isCapitalize;

  const CustomInputFieldBloc(
      {Key? key,
      this.onChanged,
      this.initialValue,
      this.isCapitalize = false,
      required this.label,
      this.inputType,
      this.icon,
      this.isNoSpace = true,
      this.isPassword = false,
      this.stream})
      : super(key: key);

  @override
  State<CustomInputFieldBloc> createState() => _CustomInputFieldBlocState();
}

class _CustomInputFieldBlocState extends State<CustomInputFieldBloc> {
  late bool _obscureText;
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _textEditingController = TextEditingController(text: widget.initialValue);
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged?.call(widget.initialValue ?? '');
    });*/
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentPadding =
        EdgeInsets.only(right: 0, left: 10, top: 8.0, bottom: 8.0);
    final enableBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
          width: 1.7,
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 218, 218, 218)),
    );
    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
          width: 1.7,
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 218, 218, 218)),
    );

    return StreamBuilder<String>(
        stream: widget.stream,
        builder: (context, snapshot) {
          return FormField<String>(
            initialValue: widget.initialValue ?? '',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                      child: TextField(
                        obscureText: _obscureText,
                        keyboardType: widget.inputType,
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          prefixIcon: widget.icon,
                          contentPadding: contentPadding,
                          enabledBorder: enableBorder,
                          focusedBorder: focusBorder,
                          hintText: widget.label,
                          suffixIcon: widget.isPassword
                              ? IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1.7,
                              color: Color.fromARGB(255, 218, 218, 218),
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        textCapitalization: widget.isCapitalize
                            ? TextCapitalization.sentences
                            : TextCapitalization.none,
                        onChanged: (text) {
                          final trimmedText = widget.isNoSpace
                              ? text.replaceAll(' ', '')
                              : text;

                          widget.onChanged?.call(trimmedText);
                        },
                      ),
                    ),
                    if (snapshot.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          snapshot.error.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 194, 18, 18)),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        });
  }
}
