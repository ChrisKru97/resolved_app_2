import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
          child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.lightGreen[300], Colors.teal[300]])),
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(),
              Text(
                "Konference\nRESOLVED",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 7,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child: IconButton(
                  icon: Icon(Icons.chevron_right),
                  color: Colors.white,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 40),
                  iconSize: MediaQuery.of(context).size.width / 7,
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/menu'),
                ),
              )
            ],
          ),
        ),
      ));
}
