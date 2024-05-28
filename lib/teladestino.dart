import 'package:flutter/material.dart';

class TelaResultado extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Function resetQuiz;

  TelaResultado(
    this.score,
    this.totalQuestions,
    this.resetQuiz,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/tarca.png',
              color: const Color(0x802b2626),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'PARABÉNS VOCÊ É O MELHOR!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xfff9e904),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pontuação Final: $score / $totalQuestions',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xff19cf08),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    resetQuiz();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Reiniciar Quiz',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff0ab721),
                    onPrimary: Color(0xffd4f903),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    minimumSize: Size(double.infinity, 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
