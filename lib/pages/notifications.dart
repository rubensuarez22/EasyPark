import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:easypark/main.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];

  TextEditingController notificationController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarNotificaciones();
  }

  Future<void> cargarNotificaciones() async {
    /*try {
      final querySnapshot = await FirebaseFirestore.instance.collection('notifications').get();
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print('Notificaciones existentes borradas correctamente.');
    } catch (error) {
      print('Error al borrar las notificaciones existentes: $error');
    }*/
    
    final snapshot = await FirebaseFirestore.instance.collection('notifications').get();
    final notificaciones = snapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      notifications = notificaciones;
    });

    print('Notificaciones cargadas:');
    notifications.forEach((notification) {
      print(notification);
    });
  }


  @override
  Widget build(BuildContext context) {
    final userIdProvider = Provider.of<UserIdProvider>(context);
    final userId = userIdProvider.userId;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                controller: notificationController,
                decoration: InputDecoration(
                  labelText: 'Notificación',
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'Id',
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                agregarNotificacion(
                  notificationController.text,
                  idController.text,
                );
                notificationController.clear();
                idController.clear();
              },
              child: Text('Agregar Notificación'),
            ),*/
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  if (notification['id'] == '0' || notification['id'] == userId) {
                    return Column(
                      children: [
                        if (index == 0)
                          Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                        NotificationsTile(
                          notification: notification['notification'],
                          unread: notification['unread'] as bool,
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(); // No se muestra esta notificación
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void agregarNotificacion(String notification, String idNotification) {
    FirebaseFirestore.instance
        .collection('notifications')
        .add({
          'notification': notification,
          'id': idNotification,
          'unread': true,
        })
        .then((value) => print('Notificación agregada con ID: ${value.id}'))
        .catchError((error) => print('Error al agregar notificación: $error'));
  }
}

class NotificationsTile extends StatelessWidget {
  final String notification;
  //final String imagePath;
  final bool unread;

  NotificationsTile({
    required this.notification,
    //required this.imagePath,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: unread ? Colors.grey[300] : Colors.white,
      child: ListTile(
        //leading: Image.asset(imagePath),
        title: Text(
          notification,
          textAlign: TextAlign.center,
        ),
        //trailing: unread ? Icon(Icons.circle, color: Colors.red) : null,
      ),
    );
  }
}
