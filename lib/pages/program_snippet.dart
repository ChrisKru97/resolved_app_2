import 'package:flutter/material.dart';

import 'program_part.dart';
import 'types.dart';

class ProgramSnippet extends StatelessWidget {
  ProgramSnippet(this.day, this.speakers);

  final Day day;
  final List<Speaker> speakers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            day.title,
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.1,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height - 159,
            child: Material(
                color: Colors.lime[100],
                child: ListView.builder(
                  itemCount: day.schedule.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == day.schedule.length)
                      return Container(height: 100);
                    final schedule = day.schedule.elementAt(index);
                    return ProgramPart(
                        schedule,
                        schedule.speaker != null
                            ? schedule.speaker is List
                                ? (schedule.speaker as List<dynamic>)
                                    .map((entry) => speakers.firstWhere(
                                        (speaker) => speaker.id == entry,
                                        orElse: () => Speaker(entry)))
                                    .toList()
                                : speakers.firstWhere(
                                    (speaker) => speaker.id == schedule.speaker,
                                    orElse: () => Speaker(schedule.speaker))
                            : null);
                  },
                )))
      ],
    );
  }
}
