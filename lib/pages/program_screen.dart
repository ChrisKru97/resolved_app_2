import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'program_snippet.dart';
import 'types.dart';

String parseDateTitle(DateTime date) {
  String weekday = "";
  switch (date.weekday) {
    case DateTime.sunday:
      weekday = "Neděle";
      break;
    case DateTime.saturday:
      weekday = "Sobota";
      break;
    case DateTime.friday:
      weekday = "Pátek";
      break;
  }
  return '$weekday ${date.day}.${date.month}';
}

class ProgramScreen extends StatelessWidget {
  ProgramScreen(this.days, this.speakers);

  final List<Day> days;
  final List<Speaker> speakers;

  @override
  Widget build(BuildContext context) {
    if (days.length == 0) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
        color: Colors.lime[100],
        child: SafeArea(
          child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                enableInfiniteScroll: false,
              ),
              items: days.map((day) => ProgramSnippet(day, speakers)).toList()),
        ));
  }
}
