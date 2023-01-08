import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/signup_screen.dart';

import '../providers/contact_provider.dart';
import '../styles/styles.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Login',
                  style: Styles.headerTextStyle,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Enter Email ',
                style: Styles.fieldTextStyle,
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                  contentPadding: const EdgeInsets.all(18),
                  hintText: 'email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(20, 10, 38, 1), width: 1),
                  ),
                  hintStyle: Styles.hintTextStyle,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Create Password',
                style: Styles.fieldTextStyle,
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  contentPadding: const EdgeInsets.all(18),
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(20, 10, 38, 1), width: 1),
                  ),
                  hintStyle: Styles.hintTextStyle,
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: SizedBox(
                  height: 52,
                  width: 280,
                  child: Consumer<ContactProvider>(
                      builder: (context, loginProvider, child) {
                    return ElevatedButton(
                      onPressed: () async {

                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          var data = await loginProvider.loginUser(
                              _emailController.text, _passwordController.text);
                          print(data['msg']);

                          if(loginProvider.userData?.msg == "User logged in"){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileScreen()),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(data['msg']),
                              ),
                            );
                          }else if(loginProvider.userData?.msg == "Email does not exist"){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(data['msg']),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(data['msg']),
                              ),
                            );
                          }

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.black,
                              content: Text('Please fill in all the fields!'),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.deepPurple,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: loginProvider.isLoadingLogin ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'login',
                        style: Styles.buttonTextStyle,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Center(
                  child: Text(
                    'Not registered? Create Account',
                    textAlign: TextAlign.center,
                    style: Styles.nameTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}


