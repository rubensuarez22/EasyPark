import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': '¿Donde puedo pagar el boleto de estacionamiento?',
      'answer':
          'Lo puedes pagar en Circle K o en los módulos que se encuentran sobre el circuito'
    },
    {
      'question': '¿Se puede pagar con tarjeta?',
      'answer':
          'Claro, puedes pagar en efectivo o con tarjeta de débito/crédito'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns elements to the start
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 40.0, left: 18.0), // Padding to push the title down
            child: const Text(
              'Preguntas frecuentes',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    FaqTile(
                      question: faqs[index]['question']!,
                      answer: faqs[index]['answer']!,
                    ),
                    Divider(
                      color: Colors.orange,
                      thickness: 2.0,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
