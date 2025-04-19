import 'package:flutter/material.dart';
import 'package:tugas3_tpm/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _isLogin = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Form(
          key: formkey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: SizedBox(
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Selamat datang di Tugas 3 TPM AFA'),
                    SizedBox(
                      height: 20.0,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/person1.jpg'),
                      radius: 100,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "kosong cuy";
                        }
                        return null;
                      },
                      controller: _username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "kosong cuy";
                        }
                        return null;
                      },
                      controller: _password,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 18.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            if (_username.text == '123' &&
                                _password.text == '123') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login Berhasil'),
                                ),
                              );
                              setState(() {
                                _isLogin = true;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DashboardPage(
                                  username: _username.text,
                                );
                              }));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Username atau Password Salah'),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
