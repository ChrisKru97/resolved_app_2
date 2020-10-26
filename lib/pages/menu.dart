import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MenuItem {
  const MenuItem(this.route, this.label, {this.image});

  final String label;
  final String route;
  final String image;
}

var menuItems = [
  MenuItem('/upcoming', 'Nádcházející'),
  MenuItem('/speakers', 'Řečníci'),
  MenuItem('/contacts', 'Kontakty')
];

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.lightGreen[300], Colors.teal[300]])),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: menuItems
                          .map((menuItem) => Container(
                                margin: EdgeInsets.all(15),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(menuItem.route),
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.orange[200]
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: menuItem.image != null
                                              ? DecorationImage(
                                                  image: AssetImage(
                                                      menuItem.image),
                                                  fit: BoxFit.cover)
                                              : null),
                                      child: Center(
                                        child: Text(
                                          menuItem.label,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ))
                          .toList()),
                ),
              ),
            ),
          ),
        ),
      );
}
