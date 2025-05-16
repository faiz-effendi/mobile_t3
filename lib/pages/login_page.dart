import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isObscure = true;

  // Dummy accounts
  final List<Map<String, String>> dummyAccounts = [
    {'username': 'admin', 'password': '123'},
    {'username': 'abraar', 'password': '123'},
  ];

  // Save login state to SharedPreferences
  Future<void> saveLoginState(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', username);
  }

  // Validate login
  void validateLogin() async {
    if (formkey.currentState!.validate()) {
      final inputUsername = _username.text;
      final inputPassword = _password.text;

      // Check if the input matches any dummy account
      final account = dummyAccounts.firstWhere(
        (account) =>
            account['username'] == inputUsername &&
            account['password'] == inputPassword,
        orElse: () => {},
      );

      if (account.isNotEmpty) {
        // Save login state and navigate to Dashboard
        await saveLoginState(inputUsername);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Berhasil')),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DashboardPage(username: inputUsername);
        }));
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau Password Salah')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: SizedBox(
              height: 550,
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Selamat datang di Tugas 3 TPM AFA'),
                    const SizedBox(height: 20.0),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/person1.jpg'),
                      radius: 100,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username tidak boleh kosong";
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
                    const SizedBox(height: 2.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: _password,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        fillColor: Colors.green,
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
                    const SizedBox(height: 18.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: validateLogin,
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to Dashboard as Guest
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DashboardPage(
                              username: 'Guest', // Provide "Guest" username
                            );
                          }));
                        },
                        child: const Text('Login as Guest'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
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