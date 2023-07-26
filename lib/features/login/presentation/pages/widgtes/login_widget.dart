import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/login/presentation/cubit/login_cubit.dart';
import 'package:order/features/register/presentation/pages/register_page.dart';

import '../../../../../core/util/botton_auth_row_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _controller_email;
  late TextEditingController _controller_password;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller_email = TextEditingController();
    _controller_password = TextEditingController();
  }

  @override
  void dispose() {
    _controller_email.dispose();
    _controller_password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 60),
            child: Text(
              'Welcome back',
              style: TextStyle(fontSize: 30, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Form(
            key: _keyform,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return 'please fill the form';
                }
              },
              controller: _controller_email,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _controller_password,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(327, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                setState(() {
                  if (_keyform.currentState!.validate()) {
                    context.read<LoginCubit>().remoteLogin(
                        _controller_email.text.trim(),
                        _controller_password.text);
                  } else {
                    return;
                  }
                });
              },
              child: const Text('Log in'),
            ),
          ),
          BottomAuthRowWidget(
            text: "Don't have an account",
            value: "Register Now",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            )),
          ),
        ],
      ),
    );
  }
}
