import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/models/contacts_model.dart';
import '../models/user_login_model.dart';

class ContactProvider extends ChangeNotifier {
  bool _isLoadingFetch = false;

  bool get isLoadingFetch => _isLoadingFetch;

  bool _isLoadingCreate = false;

  String _resMessage = "";
  String get resMessage => _resMessage;

  bool get isLoadingCreate => _isLoadingCreate;

  bool _isLoadingLogin = false;

  bool get isLoadingLogin => _isLoadingLogin;

  bool _isLoadingAdd = false;

  bool get isLoadingAdd => _isLoadingAdd;

  bool _isLoadingEdit = false;

  bool get isLoadingEdit => _isLoadingEdit;

  bool _isLoadingDelete = false;

  bool get isLoadingDelete => _isLoadingDelete;

  UserLoginModel? _userData;

  UserLoginModel? get userData => _userData;

  List<ContactsModel?>? _contacts = [];

  List<ContactsModel?>? get contacts => _contacts;

  List<ContactsModel?>? _contactsDisplay = [];

  List<ContactsModel?>? get contactsDisplay => _contactsDisplay;

  ContactsModel? _selectedContact;

  ContactsModel? get selectedContact => _selectedContact;

  void updateSelectedContact(ContactsModel contact) {
    _selectedContact = contact;
    notifyListeners();
  }

  // create account
  Future<bool> createAccount(
      BuildContext context, String name, String email, String password) async {
    _isLoadingCreate = true;
    notifyListeners();

    bool isSent = false;
    final body = {
      "name": name,
      "email": email,
      "password": password,
    };
    try {
      final response = await http.post(
        Uri.parse('https://contact.dace.info/api/users'),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 202 || response.statusCode == 201) {
        isSent = true;

        // ignore: use_build_context_synchronously
        _isLoadingCreate = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text('Account created successfully!'),
          ),
        );
      }else if(response.statusCode == 400){
        final decodedResponse = jsonDecode(response.body);
        _isLoadingCreate = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(decodedResponse['msg']),
          ),
        );
      }
      _isLoadingCreate = false;
      notifyListeners();
    } catch (e) {
      debugPrint('error');
    }

    return isSent;
  }

  // login user
  Future<dynamic> loginUser(String email, String password) async {
    _isLoadingLogin = true;
    notifyListeners();

    bool isSent = false;
    final body = {
      "email": email,
      "password": password,
    };
    try {
      final response = await http.post(
        Uri.parse('https://contact.dace.info/api/auth'),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        isSent = true;
        _isLoadingLogin = false;
        notifyListeners();

        _userData = loginModelFromJson(response.body);
        getContacts();
        notifyListeners();

        return jsonDecode(response.body);
      }else{
        final decodedResponse = json.decode(response.body);
        _resMessage = decodedResponse['msg'];
        _isLoadingLogin = false;
        notifyListeners();
      }
      _isLoadingLogin = false;
      notifyListeners();
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('error');
    }
    return isSent;
  }

  //fetch contacts
  Future<List<ContactsModel?>> getContacts() async {
    print("token in get contacts==========${_userData?.token}");
    List<ContactsModel?>? contactsHere = [];
    _contactsDisplay = [];
    _isLoadingFetch = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://contact.dace.info/api/contact'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '${_userData?.token}',
        },
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print('fetch success');
        contactsHere = contactsModelFromJson(response.body);
        _contacts = contactsHere!.reversed.toList();
        _contactsDisplay!.addAll(_contacts!);

        _isLoadingFetch = false;
        notifyListeners();
      }
      _isLoadingFetch = false;
      notifyListeners();
    } catch (err) {
      debugPrint(err.toString());
    }
    _isLoadingFetch = false;
    notifyListeners();
    return contactsHere!;
  }

  // Add contact
  Future<bool> addContact(BuildContext context, String name, String email,
      int phone, String type) async {
    _isLoadingAdd = true;
    print(_userData?.token);
    notifyListeners();

    bool isSent = false;
    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "type": type,
    };
    try {
      final response = await http.post(
        Uri.parse('https://contact.dace.info/api/contact'),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '${_userData?.token}',
        },
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print('contact added');
        isSent = true;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text('Saved successfully!'),
          ),
        );

        _isLoadingAdd = false;
        notifyListeners();
      }
      _isLoadingAdd = false;
      notifyListeners();
    } catch (e) {
      debugPrint('error');
    }
    return isSent;
  }

  // Edit contact
  Future<bool> editContact(BuildContext context, String name, String email,
      int phone, String type, String id) async {
    _isLoadingEdit = true;
    print(_userData?.token);
    notifyListeners();

    bool isSent = false;
    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "type": type,
    };
    try {
      final response = await http.patch(
        Uri.parse('https://contact.dace.info/api/contact/$id'),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '${_userData?.token}',
        },
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print('contact added');
        isSent = true;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text('Saved successfully!'),
          ),
        );

        _isLoadingEdit = false;
        notifyListeners();
      }
      _isLoadingEdit = false;
      notifyListeners();
    } catch (e) {
      debugPrint('error');
    }
    return isSent;
  }

  // delete contact
  Future<bool> deleteContact(String id) async {
    _isLoadingDelete = true;
    bool deleted = false;
    notifyListeners();

    try {
      var url = Uri.parse('https://contact.dace.info/api/contact/$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': '${_userData?.token}',
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 202) {
        getContacts();
        _isLoadingDelete = false;
        deleted = true;
      } else {
        throw Exception('Failed to delete contact');
      }
    } catch (error) {
      print("Exception: ${error.toString()}");
    }

    return deleted;
  }
}
