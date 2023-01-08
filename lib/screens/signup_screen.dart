import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/signin_screen.dart';

import '../providers/contact_provider.dart';
import '../styles/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = context.watch<ContactProvider>();
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
                  'Sign Up',
                  style: Styles.headerTextStyle,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Enter name ',
                style: Styles.fieldTextStyle,
              ),
              const SizedBox(height: 5),
              TextFormField(
                maxLength: 25,
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if(value.toString().length < 4){
                    return "Name cannot be less than 4 characters";
                  } else{
                    return null;
                  }

                },
                decoration: InputDecoration(
                  filled: true,
                  counterText: "",
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.drive_file_rename_outline,
                  ),
                  contentPadding: const EdgeInsets.all(18),
                  hintText: 'name',
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
              TextFormField(
                controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if(value.toString().length < 6){
                    return "Password cannot be less than 6 characters";
                  }else if(!hasNumber(value!)){
                    return "Password must contain number";
                  } else{
                    return null;
                  }

                },

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
                      builder: (context, createAccountProvider, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_nameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {

                         bool isCreated =  await createAccountProvider.createAccount(
                              context,
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text);

                         if(isCreated){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => const SigninScreen()),
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
                      child: createAccountProvider.isLoadingCreate
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Create Account',
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
                        builder: (context) => const SigninScreen()),
                  );
                },
                child: const Center(
                  child: Text(
                    'Already have an account? Login',
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

bool hasNumber(String value) {
  String pattern = r'[0-9]';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}
