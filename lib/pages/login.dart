import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isChecked = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final String id = _idController.text.trim();
      final String password = _passwordController.text.trim();

      if (await _validateCredentials(id, password)) {
        Navigator.pushReplacementNamed(context, '/mainNavigation');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("ID o contraseña incorrecta"),
        ));
      }
    }
  }

  Future<bool> _validateCredentials(String id, String password) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: id)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      }
    } catch (e) {
      print("Error al verificar las credenciales: $e");
    }
    return false;
  }

  void createUser(String userId, String password) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'password': password}).then((_) {
      print("Usuario creado con éxito.");
    }).catchError((error) {
      print("Error creando usuario: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/udlap_logo.png'),
            SizedBox(height: 32.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0),
                      labelText: 'ID',
                      labelStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(112, 40, 51, 74),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(218, 122, 55, 0.27),
                      hintText: 'ID Institucional',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese su ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(112, 40, 51, 74),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(218, 122, 55, 0.27),
                      hintText: 'Constraseña',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      }
                      return null;
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: _login,
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 119, 108, 108),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text("¿Olvidaste tu contraseña?"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale:
                                0.8, // Adjust the scale factor to suit your needs
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: _login,
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 119, 108, 108),
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text("Mantener la sesión iniciada"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: _login,
                    child: const Text('Iniciar sesión'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(217, 218, 123, 55),
                      minimumSize: Size(double.infinity, 40),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _login,
                        child: Text("Iniciar sesión como invitado"),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(217, 218, 123, 55),
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
