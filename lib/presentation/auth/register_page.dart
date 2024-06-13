import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_2024/data/models/request/register_request_model.dart';
import 'package:training_2024/presentation/auth/bloc/register/register_bloc.dart';
import 'package:training_2024/presentation/auth/login_page.dart';
import 'package:training_2024/theme.dart';
import 'package:training_2024/widgets/custom_text_field.dart';
import 'package:training_2024/widgets/note_logo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: StyleCustome.green,
        centerTitle: true,
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
            CustomTextField(
              controller: _nameController,
              labelText: "Name",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name cannot be empty";
                } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                    .hasMatch(value)) {
                  return "Name cannot contain special characters";
                }
                return null;
              },
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
                  return "Please enter a valid email";
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is RegisterSucces) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }
                  if (state is RegisterFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        padding: const EdgeInsets.all(10),
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() != true) {
                          return;
                        }
                        //register
                        final dataModel = RegisterRequestModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        context
                            .read<RegisterBloc>()
                            .add(RegisterButtonPressed(data: dataModel));
                      },
                      style: const ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(color: StyleCustome.green)),
                      ),
                      child: const Text("Register"),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Already Have an Account?",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login",
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
