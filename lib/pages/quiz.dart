import 'package:flutter/material.dart';
import 'package:astroguide_flutter/services/quiz_service.dart';

class QuizListPage extends StatefulWidget {
  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  List<dynamic> quizzes = [];

  @override
  void initState() {
    super.initState();
    obtenerQuizzes();
  }

  Future<void> obtenerQuizzes() async {
    try {
      final List<dynamic> listaQuizzes = await QuizService.getQuiz();
      setState(() {
        quizzes = listaQuizzes;
      });
    } catch (e) {
      // Manejar errores
      print('Error al obtener quizzes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
      ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de detalles del quiz
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizDetailPage(quiz: quiz),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz['Titulo'] ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    quiz['pregunta'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizDetailPage extends StatefulWidget {
  final dynamic quiz;

  const QuizDetailPage({Key? key, required this.quiz}) : super(key: key);

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  List<String> shuffledAnswers = [];
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    // Obtener respuestas y reorganizarlas aleatoriamente
    shuffledAnswers = [
      widget.quiz['RespuestaCorrecta'],
      widget.quiz['Respuesta2'],
      widget.quiz['Respuesta3'],
      widget.quiz['Respuesta4'],
    ]..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz['titulo'] ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quiz['Pregunta'] ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var answer in shuffledAnswers)
                  RadioListTile<String>(
                    title: Text(answer ?? ''),
                    value: answer,
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
