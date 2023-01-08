import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/providers/contact_provider.dart';
import 'package:test_app/screens/add_contact_screen.dart';
import 'package:test_app/screens/widgets/contact_item.dart';

import '../models/contact_model.dart';
import '../styles/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String token = '';

  // @override
  // Future<void> initState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  username = prefs.getString('username')!;
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    getToken();
    print(token);
  }

  void getToken() async {
    var prefs = await _prefs ;
    token = prefs.getString('token')??'';
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<ContactProvider>();
    final getContactsProvider = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 0, 51, 1),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddContactScreen(),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Consumer<ContactProvider>(
            builder: (context, contactProvider, child) {
            return contactProvider.isLoadingFetch
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: [
                SizedBox(height: 15),
                Text(
                  loginProvider.userData?.user?.name??"No Name",
                  style: Styles.nameTextStyle,
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: getContactsProvider.contacts?.length,
                  itemBuilder: (context, index) {
                    final contact = getContactsProvider.contacts?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ContactItem(
                        contactValues: contact!,
                      ),
                    );
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
