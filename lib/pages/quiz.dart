import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:astroguide_flutter/services/quiz_service.dart';
import 'package:http/http.dart' as http;



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
    shuffledAnswers = [
      widget.quiz['RespuestaCorrecta'],
      widget.quiz['Respuesta2'],
      widget.quiz['Respuesta3'],
      widget.quiz['Respuesta4'],
    ]..shuffle();
  }

  Future<void> enviarRespuesta() async {
    var body = jsonEncode({
      'quiz_id': widget.quiz['id'],
      'respuestas_cliente': [selectedAnswer],
    });

    var url = Uri.parse('https://10.0.2.2:8000/api/quizs/validar-terminacion');
    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      bool quizCompletado = data['quiz_terminado_correctamente'];
      if (quizCompletado) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Completado'),
              content: Text('¡Felicidades! Has completado el quiz correctamente.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Incompleto'),
              content: Text('Lo siento, parece que el quiz no fue completado correctamente. Por favor, inténtalo nuevamente.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Hubo un error al intentar enviar la respuesta. Por favor, inténtalo nuevamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz['titulo'] ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 20),
              Text(
                widget.quiz['Pregunta2'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                    title: Text(widget.quiz['RespuestaCorrecta2'] ?? ''),
                    value: widget.quiz['RespuestaCorrecta2'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(widget.quiz['Respuesta5'] ?? ''),
                    value: widget.quiz['Respuesta5'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(widget.quiz['Respuesta6'] ?? ''),
                    value: widget.quiz['Respuesta6'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(widget.quiz['Respuesta7'] ?? ''),
                    value: widget.quiz['Respuesta7'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                widget.quiz['Pregunta3'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                    title: Text(widget.quiz['RespuestaCorrecta3'] ?? ''),
                    value: widget.quiz['RespuestaCorrecta3'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(widget.quiz['Respuesta8'] ?? ''),
                    value: widget.quiz['Respuesta8'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(widget.quiz['Respuesta9'] ?? ''),
                    value: widget.quiz['Respuesta9'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(widget.quiz['Respuesta10'] ?? ''),
                    value: widget.quiz['Respuesta10'],
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: enviarRespuesta,
                child: Text('Enviar respuesta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
   RespuestaCorrectaPage() {} // Si este es un widget, asegúrate de definirlo adecuadamente.
}