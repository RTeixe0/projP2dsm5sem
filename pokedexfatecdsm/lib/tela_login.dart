import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'tela_home.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper();

  bool _isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final user = await dbHelper.getUser(_emailController.text, _passController.text);

    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TelaHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha inválidos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) =>
                      value != null && value.contains('@') ? null : "Email inválido",
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Senha"),
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : "Senha obrigatória",
                ),
                const SizedBox(height: 32),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Entrar"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
