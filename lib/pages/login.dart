import 'package:easypark/pages/PreguntasFrecuentes.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  void _login() {
    // Implement your login logic here
    /*if (_formKey.currentState!.validate()) {
      // Perform login with _username and _password
      print('Username: $_username');
      print('Password: $_password');
    }*/
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FaqPage()),);
  }

  bool isChecked = false;

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
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
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
                    onSaved: (value) {
                      _password = value!;
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
