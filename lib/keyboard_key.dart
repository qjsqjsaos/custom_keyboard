import 'package:flutter/material.dart';

class KeyBoardKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const KeyBoardKey(
      {Key? key, required this.label, required this.value, required this.onTap})
      : super(key: key);

  @override
  _KeyBoardKeyState createState() => _KeyBoardKeyState();
}

class _KeyBoardKeyState extends State<KeyBoardKey> {

  renderLabel() {
    if(widget.label is Widget){
      return widget.label;
    }
    return Text(widget.label,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: AspectRatio(
        aspectRatio: 2, //넓이 / 높이 = 2
        child: Center(
            child: renderLabel()),
      ),
    );
  }
}
