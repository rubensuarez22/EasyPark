import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'notification': 'El estacionamiento E-1 está cerrado',
      'imagePath': 'assets/images/exclamationMark.png',
      'unread': true,
    },
    {
      'notification':
          'Recuerda que puedes comprar boletos de estacionamiento en Circle K, Tienda Universitaria y el Comedor Américas',
      'imagePath': 'assets/images/lightbulb.png',
      'unread': true,
    },
    {
      'notification': '¿Sigues dentro de la universidad?',
      'imagePath': 'assets/images/questionMark.png',
      'unread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            top: 40, // Adjust this value to move the title down more or less
            left: 18,
            right: 0,
            child: Text(
              'Notificaciones',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 70.0), // Add top padding to prevent overlap with the title
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0)
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                          NotificationsTile(
                            notification: notifications[index]['notification']!,
                            imagePath: notifications[index]['imagePath']!,
                            unread: notifications[index]['unread'] as bool,
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                        ],
                      );
                    },
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

class NotificationsTile extends StatelessWidget {
  final String notification;
  final String imagePath;
  final bool unread;

  NotificationsTile(
      {required this.notification,
      required this.imagePath,
      required this.unread});

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
      ),
    );
  }
}
