import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'types.dart';

class Contacts extends StatelessWidget {
  Contacts(this.contacts);

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    if (contacts.length == 0) {
      return Center(child: CircularProgressIndicator());
    }
    final textStyle =
        TextStyle(fontSize: MediaQuery.of(context).size.width / 15);
    return Material(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.lightGreen[300], Colors.teal[300]])),
            child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (_, index) {
                  final Contact contact = contacts.elementAt(index);
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.indigo[100].withOpacity(0.3)),
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(contact.name, style: textStyle),
                              Text(contact.role, style: textStyle),
                            ],
                          ),
                          InkWell(
                            onTap: () => launch('tel:${contact.number}'),
                            child: Text(contact.number,
                                style: textStyle.copyWith(
                                    color: Colors.blue[800],
                                    decoration: TextDecoration.underline,
                                    shadows: [])),
                          )
                        ],
                      ));
                })));
  }
}
