import 'package:flutter/material.dart';
import 'telaquestoes.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/FIFA QUIZ.png',
              fit: BoxFit.cover,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff378712),
              onPrimary: Color(0xffe76903),
              padding: EdgeInsets.symmetric(vertical: 15.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(),
                ),
              );
            },
            child: Text(
              'INICAR QUIZ',
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xffffe706),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
