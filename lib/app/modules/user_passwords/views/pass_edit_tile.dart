import 'package:flutter/material.dart';

class PasswordEditItem extends StatelessWidget {
  PasswordEditItem({
    super.key,
    required this.pKey,
    required this.passwordId,
    required this.value,
  });
  String pKey;
  String value;
  String passwordId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TextFormField(
            initialValue: pKey,
            decoration: const InputDecoration(label: Text("Key")),
            style: const TextStyle(fontSize: 13),
          ),
        ),
        Flexible(child: Container()),
        Flexible(
          child: TextFormField(
            initialValue: value,
            decoration: const InputDecoration(label: Text("Value")),
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
