import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_2024/pages/home_page.dart';
import 'package:training_2024/presentation/auth/bloc/login/login_bloc.dart';
import 'package:training_2024/presentation/auth/register_page.dart';
import 'package:training_2024/theme.dart';
import 'package:training_2024/widgets/custom_text_field.dart';
import 'package:training_2024/widgets/note_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleCustome.green,
        centerTitle: true,
        title: const Text(
          "Login Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 64,
            ),
            const NoteLogo(),
            const Text(
              "IDN Notes App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: StyleCustome.green,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              controller: _emailController,
              labelText: "Email",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email cannot be empty";
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return "Email is not valid";
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _passwordController,
              labelText: "Password",
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password cannot be empty";
                }
                if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSucces) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                  if (state is LoginFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() != true) {
                          return;
                        }
                        // TODO: Add login logic
                        context.read<LoginBloc>().add(LoginButtonPressed(
                            email: _emailController.text,
                            password: _passwordController.text));
                      },
                      style: const ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(color: Colors.blue)),
                      ),
                      child: const Text("Login"),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't Have an Account?",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text("Register",
                      style: TextStyle(decoration: TextDecoration.underline)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
