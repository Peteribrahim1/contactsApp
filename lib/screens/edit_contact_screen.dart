import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/contacts_model.dart';
import 'package:test_app/styles/styles.dart';

import '../providers/contact_provider.dart';

class EditContactScreen extends StatefulWidget {
  final ContactsModel uneditedContact;

  const EditContactScreen({Key? key, required this.uneditedContact})
      : super(key: key);

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.uneditedContact.name!;
    _emailController.text = widget.uneditedContact.email!;
    _phoneController.text = widget.uneditedContact.phone!;
    _typeController.text = widget.uneditedContact.type!;
    super.initState();
  }

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
              'Edit Contact',
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
                    builder: (context, editContactProvider, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _typeController.text.isNotEmpty) {
                        bool isEdited = await editContactProvider.editContact(
                          context,
                          _nameController.text,
                          _emailController.text,
                          int.parse(_phoneController.text),
                          _typeController.text,
                          widget.uneditedContact.id.toString(),
                        );

                        if (isEdited) {
                          editContactProvider.getContacts();
                        }
                        Navigator.pop(context);
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
                    child: editContactProvider.isLoadingEdit
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Update contact',
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
