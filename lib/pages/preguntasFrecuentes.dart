import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': '¿Donde puedo pagar el boleto de estacionamiento?',
      'answer': 'Lo puedes pagar en Circle K o en los módulos que se encuentran sobre el circuito'
    },
    {
      'question': '¿Se puede pagar con tarjeta?',
      'answer': 'Claro, puedes pagar en efectivo o con tarjeta de débito/crédito'
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Color de fondo naranja
        title: Text('Preguntas Frecuentes'), // Título "Preguntas Frecuentes"
        centerTitle: true, // Centra el título en la pantalla
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              FaqTile(
                question: faqs[index]['question']!,
                answer: faqs[index]['answer']!,
              ),
              Divider(
                color: Colors.orange, // Color de la línea horizontal naranja
                thickness: 2.0, // Grosor de la línea horizontal
              ),
            ],
          );
        },
      ),
    );
  }
}

class FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(question),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
