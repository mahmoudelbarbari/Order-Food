import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/login/presentation/cubit/login_cubit.dart';
import 'package:order/features/register/presentation/pages/register_page.dart';

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
    return ListView(
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
              border: UnderlineInputBorder(),
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _controller_password,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ),
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
                      _controller_email.text.trim(), _controller_password.text);
                } else {
                  return;
                }
              });
            },
            child: const Text('Log in'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Don't have an account? "),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ));
              },
              child: const Text('Register Now'),
            )
          ],
        ),
      ],
    );
  }
}
