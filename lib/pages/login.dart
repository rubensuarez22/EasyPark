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
    if (_formKey.currentState!.validate()) {
      // Perform login with _username and _password
      print('Username: $_username');
      print('Password: $_password');
    }
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
                    decoration: InputDecoration(
                      labelText: 'ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
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
                  SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(218, 122, 55, 0.27),
                      hintText: 'Password',
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
                  SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Iniciar Sesión'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Iniciar sesion como invitado'),
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
