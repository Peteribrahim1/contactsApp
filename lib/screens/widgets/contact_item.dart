import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/contacts_model.dart';
import 'package:test_app/providers/contact_provider.dart';

import '../../styles/styles.dart';
import '../edit_contact_screen.dart';

class ContactItem extends StatefulWidget {
  final ContactsModel contactValues;

  const ContactItem({Key? key, required this.contactValues}) : super(key: key);

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(0, 0, 51, 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contactValues.name!,
                  style: Styles.normalTextStyle,
                ),
                Text(
                  widget.contactValues.email!,
                  style: Styles.normalTextStyle,
                ),
                Text(
                  widget.contactValues.phone.toString(),
                  style: Styles.normalTextStyle,
                ),
                Text(
                  widget.contactValues.type!,
                  style: Styles.normalTextStyle,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<ContactProvider>(
                    builder: (context, contactProvider, child) {
                  return InkWell(
                      onTap: () {
                        contactProvider.updateSelectedContact(widget.contactValues);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => EditContactScreen(
                            uneditedContact: contactProvider.selectedContact!,
                          ),
                        );
                      },
                      child: Icon(Icons.edit));
                }),
                SizedBox(height: 15),
                Consumer<ContactProvider>(
                  builder: (context, deleteProvider, child) {
                    return InkWell(
                        onTap: () {
                          deleteProvider.updateSelectedContact(widget.contactValues);
                          deleteProvider.deleteContact(
                              deleteProvider.selectedContact!.id!);
                        },
                        child: deleteProvider.isLoadingDelete && deleteProvider.selectedContact == widget.contactValues
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Icon(Icons.delete_outline));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
