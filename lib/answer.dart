import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;
  final bool isCorrect;

  Answer(this.selectHandler, this.answerText, this.isCorrect);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 128, 26, 146),
            onPrimary: Colors.white),
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}