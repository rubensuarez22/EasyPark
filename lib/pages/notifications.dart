import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'notification': 'El estacionamiento E-1 está cerrado',
      'imagePath' : 'assets/images/exclamationMark.png',
      'unread' : true,
    },
    {
      'notification': 'Recuerda que puedes comprar boletos de estacionamiento en Circle K, Tienda Universitaria y el Comedor Américas',
      'imagePath' :'assets/images/lightbulb.png' ,
      'unread' : true,
    },
    {
      'notification': '¿Sigues dentro de la universidad?',
      'imagePath' : 'assets/images/questionMark.png',
      'unread' : false,
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
              if (index == 0)  // Conditionally add a divider before the first element
                Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              NotificationsTile(
                notification: notifications[index]['notification']!,
                imagePath:  notifications[index]['imagePath']!,
                unread: notifications[index]['unread'] as bool, 
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
  final String imagePath;
  final bool unread;

  NotificationsTile({required this.notification, required this.imagePath, required this.unread});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: unread ? Colors.grey[300] : Colors.white,
      child: ListTile(
         leading: Image.asset(imagePath),
         title: Text(
            notification,
            textAlign: TextAlign.center,
          ), 
         trailing: unread ? Icon(Icons.circle, color: Colors.red) : null, 
      )
     
    
    );
  }
}
