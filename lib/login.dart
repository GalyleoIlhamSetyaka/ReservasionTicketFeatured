import 'package:flutter/material.dart';
import 'package:ReservasiKalilo/admin/konfirmasi.dart';
import 'package:ReservasiKalilo/register.dart';
import 'package:ReservasiKalilo/main.dart';
import 'api_provider.dart'; // Import your ApiProvider class

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(100, 181, 246, 1),
              Color.fromRGBO(43, 90, 219, 1),
            ],
          ),
        ),
        child: Center(
          child: Card(
            color: Color.fromRGBO(216, 216, 216, 1),
            elevation: 8,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_circle_rounded,
                    size: 50,
                    color: Colors.black,
                  ),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      // Check if the input is valid.
                      if (username.isNotEmpty && password.isNotEmpty) {
                        // Call the login endpoint
                        final loginSuccessful =
                            await ApiProvider.loginUser(username, password);

                        if (loginSuccessful) {
                          // Simulate user type (admin or user) based on input
                          // Replace this logic with your actual user type determination.
                          if (username == 'admin') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Konfirmasi(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Main(),
                              ),
                            );
                          }
                        } else {
                          // Handle unsuccessful login (show an error message, etc.)
                          print('Login failed. Invalid credentials.');
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Navigate to the registration screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterForm(),
                        ),
                      );
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
