import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? ispass;
  final String? hintTxt;
  final String? labelTxt;
  final String? heperTxt;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget(
      {super.key,
      this.controller,
      this.fieldKey,
      this.heperTxt,
      this.hintTxt,
      this.inputType,
      this.ispass,
      this.labelTxt,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureTxt = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(.35),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        style: const TextStyle(color: Colors.black87, fontSize: 22),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.ispass == true ? _obscureTxt : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintTxt,
          hintStyle: const TextStyle(color: Colors.black26),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureTxt = !_obscureTxt;
              });
            },
            child: widget.ispass == true
                ? Icon(
                    _obscureTxt ? Icons.visibility_off : Icons.visibility,
                    color: _obscureTxt == false ? Colors.blue : Colors.grey,
                  )
                : const Text(""),
          ),
        ),
      ),
    );
  }
}
