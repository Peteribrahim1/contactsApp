import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/styles/styles.dart';

import '../providers/contact_provider.dart';

class AddContactScreen extends StatefulWidget {
  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Contact',
              textAlign: TextAlign.center,
              style: Styles.bigTextStyle,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              style: Styles.normalTextStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              style: Styles.normalTextStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Phone',
              ),
              style: Styles.normalTextStyle,
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                hintText: 'Type',
              ),
              style: Styles.normalTextStyle,
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                height: 52,
                width: 280,
                child: Consumer<ContactProvider>(
                    builder: (context, addContactProvider, child) {
                  return ElevatedButton(
                    onPressed: () async{
                      if (_nameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _typeController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty) {
                       bool isAdded = await addContactProvider.addContact(
                            context,
                            _nameController.text,
                            _emailController.text,
                            int.parse(_phoneController.text),
                            _typeController.text);

                        if(isAdded){
                          addContactProvider.getContacts();
                        }
                        Navigator.pop(context);
                        print('add successssss');
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: addContactProvider.isLoadingAdd
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Add contact',
                            style: Styles.buttonTextStyle,
                          ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
