// ignore_for_file: deprecated_member_use, prefer_const_constructors, avoid_print, sort_child_properties_last
import 'dart:ffi';

import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionId = 0;
  var _totalScore = 0;
  bool _showFinalScore = false;
  var questions = [
    {
      'questionText': 'How much salt should be consumed on a daily basis?',
      'answers': [
        {'text': '1 Teaspoon', 'isCorrect': false},
        {'text': '1/2 Teaspoon', 'isCorrect': true},
        {'text': '1/4 Teaspoon', 'isCorrect': false},
        {'text': '2 Teaspoons', 'isCorrect': false}
      ]
    },
    {
      'questionText':
          'What is the normal Blood Pressure Level of a Healthy Person?',
      'answers': [
        {'text': '<120/80', 'isCorrect': true},
        {'text': '>120/80', 'isCorrect': false},
        {'text': '>130/90', 'isCorrect': false},
        {'text': '>140/100', 'isCorrect': false}
      ]
    },
    {
      'questionText':
          'Which of the following labelled food items should a person suffering from High BP Levels should eat',
      'answers': [
        {'text': 'Low Sodium', 'isCorrect': true},
        {'text': 'High Sodium', 'isCorrect': false},
        {'text': 'Caffeine', 'isCorrect': false}
      ]
    },
    {
      'questionText': 'What is the recommended daily water intake for adults?',
      'answers': [
        {'text': '8 cups', 'isCorrect': false},
        {'text': '6 cups', 'isCorrect': false},
        {'text': '10 cups', 'isCorrect': true},
        {'text': '12 cups', 'isCorrect': false}
      ]
    },
  ];

  void _answerQuestion(bool isCorrect) {
    setState(() {
      _questionId++;
      if (_questionId >= questions.length) {
        _showFinalScore = true;
      }
    });
    if (isCorrect) {
      setState(() {
        _totalScore++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Back_Img.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('__________QUIZ__________'),
          backgroundColor: Color.fromARGB(255, 128, 26, 146),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _showFinalScore
                  ? [
                      Center(
                        child: Text(
                          'Quiz complete! You scored $_totalScore out of ${questions.length}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]
                  : [
                      Question(questions[_questionId % 4]['questionText']),
                      ...((questions[_questionId % 4]['answers'])
                              as List<Map<String, Object>>)
                          .map((answer) {
                        return Answer(
                          () => _answerQuestion(answer['isCorrect']),
                          answer['text'],
                          answer['isCorrect'],
                        );
                      }).toList(),
                      SizedBox(height: 10),
                    ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _questionId++;
                    });
                  },
                  child: _questionId < questions.length - 1
                      ? Text('Next')
                      : Text('Finish'),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 128, 26, 146),
                      onPrimary: Colors.white)),
            ),
          ],
        ),
      ),
    ));
  }
}
