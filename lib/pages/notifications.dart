import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'notification': 'El estacionamiento E-1 está cerrado',
    },
    {
      'notification': 'Recuerda que puedes comprar boletos de estacionamiento en Circle K, Tienda Universitaria y el Comedor Américas',
    },
    {
      'notification': '¿Sigues dentro de la universidad?',
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centra el título en la AppBar
        title: Text(
          'Notificaciones',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
       body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              NotificationsTile(
                notification: notifications[index]['notification']!,
              ),
              Divider(
                color: Colors.black, // Color de la línea horizontal naranja
                thickness: 1.0, // Grosor de la línea horizontal
              ),
            ],
          );
        },
      ),
    );
  }
}

class NotificationsTile extends StatelessWidget {
  final String notification;


  NotificationsTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification),
    
    );
  }
}
