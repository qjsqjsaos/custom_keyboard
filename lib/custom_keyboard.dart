import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'keyboard_key.dart';

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['00', '0', const Icon(Icons.keyboard_backspace)],
  ];

  String amount = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(children: [
            renderAmount(),
            ...renderKeyboard(),
            renderConfirmButton()
          ]),
        ));
  }

  renderAmount() {
    String display = '보낼금액';
    TextStyle style = const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color:Colors.grey
    );

    if(amount.isNotEmpty) {
      NumberFormat f = NumberFormat('#,###');

      display = f.format(int.parse(amount)) + "원";
      style = style.copyWith(
          color: Colors.black
      );
    }

    return Expanded(
      child: Center(
        child: Text(display, style: style),
      ),
    );
  }

  renderKeyboard() {
    return keys
        .map((x) => Row(
        children: x.map((y) {
          return Expanded(
            child: KeyBoardKey(
              label: y,
              value: y,
              onTap: (val) {
                if (val is Widget) {
                  onBackspacePress();
                } else {
                  if(amount.length > 11){
                    return;
                  }else {
                    onKeyTap(val);
                  }
                }
              },
            ),
          );
        }).toList()))
        .toList();
  }

  renderConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('확인', style: TextStyle(color: Colors.black)),
                )),
          ),
        ],
      ),
    );
  }

  onKeyTap(val) {
  if((val == '0' || val == '00') && amount.isEmpty){
    return;
  }

    setState(() {
      amount = amount + val;
    });
  }

  onBackspacePress() {
    if(amount.isEmpty){
      return;
    }
    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }
}
