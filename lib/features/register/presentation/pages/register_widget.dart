import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/login/presentation/pages/login_page.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/register/presentation/cubit/register_cubit.dart';

class RegisterWidget extends StatefulWidget {
  final RegisterAccountEntity registerAccountEntity;
  const RegisterWidget({super.key, required this.registerAccountEntity});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late TextEditingController _controller_username;
  late TextEditingController _controller_password;
  late TextEditingController _controller_name;
  late TextEditingController _controller_email;
  late TextEditingController _controller_gender;
  late TextEditingController _controller_phone;
  late GlobalKey<FormState> _keyform;
  late GlobalKey<FormState> _keyform1;

  @override
  void initState() {
    super.initState();
    _controller_username = TextEditingController();
    _controller_password = TextEditingController();
    _controller_name = TextEditingController();
    _controller_email = TextEditingController();
    _controller_gender = TextEditingController();
    _controller_phone = TextEditingController();
    _keyform = GlobalKey<FormState>();
    _keyform1 = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller_username.dispose();
    _controller_password.dispose();
    _controller_name.dispose();
    _controller_email.dispose();
    _controller_gender.dispose();
    _controller_phone.dispose();
    super.dispose();
  }

  String? selectedValue;
  List<String> items = [
    'Female',
    'Male',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyform,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill the form';
                    }
                  },
                  controller: _controller_username,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _controller_name,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill the form';
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  controller: _controller_email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your mail address.';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+')
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Example@gmail.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.multiline,
                  controller: _controller_password,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password.';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid password....\nYour password must be at least 8 characters long,\nattached with lowercase and uppercase letters';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String?>(
                  hint: const Text(
                    'gender',
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  value: selectedValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _controller_gender.text = value!;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _controller_phone,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.smartphone_sharp),
                  ),
                  validator: (value, {int i = 1}) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone number.';
                    }
                    if (!RegExp(
                            r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
                        .hasMatch(value)) {
                      return 'Please enter an valid phone number';
                    }
                    return null;
                  },
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
                        context.read<RegisterCubit>().registerAccountFromRemote(
                            registerAccountEntity: RegisterAccountEntity(
                              gender: _controller_gender.text.trim(),
                              name: _controller_name.text,
                              phoneNumber: _controller_phone.text,
                              username: _controller_username.text,
                            ),
                            email: _controller_email.text.trim(),
                            password: _controller_password.text);
                      }
                    });
                  },
                  child: const Text('Sign up'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: const Text('Login Now'),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
