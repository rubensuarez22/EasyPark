import 'package:easypark/pages/PreguntasFrecuentes.dart';
import 'package:easypark/pages/VistaPrincipal.dart';
import 'package:easypark/pages/notifications.dart';
import 'package:easypark/pages/parked.dart';
import 'package:easypark/pages/sugerencias.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 1;
  final screens = [NotificationsPage(), Principal(), SugerenciasView(), FaqPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: screens[selectedIndex],
          bottomNavigationBar: BottomNavigationBar (
           currentIndex: selectedIndex,
           onTap: (index){
            setState(() {
              selectedIndex = index;
            });
           },
          backgroundColor: Colors.grey, // Cambia el color de fondo de la barra de navegación
          selectedItemColor: Colors.grey, // Cambia el color de los iconos activos
          unselectedItemColor: Colors.grey, // Cambia el color de los iconos inactivos
           items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  activeIcon: Icon(Icons.notifications_rounded),
                  label: "Notificaciones"
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: "Buscador",
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.markunread_mailbox_outlined),
                  activeIcon: Icon(Icons.markunread_mailbox_rounded),
                  label: "Sugerencias"
                  ),  
                BottomNavigationBarItem(
                  icon: Icon(Icons.help_outlined),
                  activeIcon: Icon(Icons.help_rounded),
                  label: "Preguntas"
                  ),                ]
          ),
    );
  }
}


