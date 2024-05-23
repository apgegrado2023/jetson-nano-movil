import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomInputFieldState extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool isNoSpace;
  final String? initialValue;
  final bool isCapitalize;

  const CustomInputFieldState({
    Key? key,
    this.onChanged,
    this.initialValue,
    this.isCapitalize = false,
    required this.label,
    this.inputType,
    this.icon,
    this.isNoSpace = true,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomInputFieldState> createState() => _CustomInputFieldStateState();
}

class _CustomInputFieldStateState extends State<CustomInputFieldState> {
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

    return FormField<String>(
      initialValue: widget.initialValue ?? '',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                child: TextFormField(
                  obscureText: _obscureText,
                  keyboardType: widget.inputType,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    prefixIcon: widget.icon,
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    contentPadding: contentPadding,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(95, 197, 197, 197)),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
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
                    final trimmedText =
                        widget.isNoSpace ? text.replaceAll(' ', '') : text;
                    if (widget.validator != null) {
                      state.didChange(trimmedText);
                      state.validate();
                    }
                    widget.onChanged?.call(trimmedText);
                  },
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(color: Color.fromARGB(255, 194, 18, 18)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
