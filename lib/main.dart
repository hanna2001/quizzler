import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'QuestionBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBank qb = QuestionBank();

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Quizpage(),
          )),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  int w_a = 0, r_a = 0;
  bool finished = false;
  List<Icon> scoreBoard = [];
  //List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  void checkAns(bool userAns) {
    if (!finished) {
      if (qb.getAns() == userAns) {
        r_a++;
        scoreBoard.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        w_a++;
        scoreBoard.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    }
    if (qb.isFinished()) {
      finished = true;
      Alert(
          context: context,
          title: 'Finished',
          desc: 'right:$r_a wrong:$w_a',
          buttons: [
            DialogButton(
              child: Text('Redo'),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  qb.reset();
                  scoreBoard = [];
                  r_a = 0;
                  w_a = 0;
                  finished = false;
                });
              },
            )
          ]).show();
    }
    qb.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            child: Center(
              child: Text(
                qb.getQuestion(),
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  checkAns(true);
                });
              },
              child: Text('True',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              onPressed: () {
                setState(
                  () {
                    checkAns(false);
                  },
                );
              },
              child: Text(
                'False',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(
          children: scoreBoard,
        )
      ],
    );
  }
}
