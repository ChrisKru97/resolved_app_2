import 'package:flutter/material.dart';

import 'types.dart';

class ProgramPart extends StatelessWidget {
  ProgramPart(this.schedulePart, this.speaker);

  final SchedulePart schedulePart;
  final dynamic speaker;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(fontSize: MediaQuery.of(context).size.width * 0.035);
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[900], width: 2)),
        child: Column(
          children: <Widget>[
            GestureDetector(
                onTap: schedulePart.info != null
                    ? () {
                        Navigator.of(context)
                            .pushNamed('/upcoming', arguments: schedulePart);
                      }
                    : null,
                child: Text(
                  schedulePart.name,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      decoration: schedulePart.info != null
                          ? TextDecoration.underline
                          : null,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Kdy:", style: textStyle),
                Text(
                    RegExp(r"([1-9]\d{0,1}:\d{2})").stringMatch(
                        schedulePart.time.toDate().toString().split(" ")[1]),
                    style: textStyle)
              ],
            ),
            if (schedulePart.place != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Kde:", style: textStyle),
                  Text(schedulePart.place, style: textStyle),
                ],
              ),
            if (speaker != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(speaker is List ? "Řečníci:" : "Řečník:",
                      style: textStyle),
                  speaker is List
                      ? Column(
                          children: (speaker as List<Speaker>)
                              .map((entry) => GestureDetector(
                                    onTap: entry.id != null
                                        ? () {
                                            Navigator.pushNamed(
                                                context, '/speakers',
                                                arguments: entry);
                                          }
                                        : null,
                                    child: Text(entry.name,
                                        style: entry.id != null
                                            ? textStyle.copyWith(
                                                color: Colors.blue[800],
                                                decoration:
                                                    TextDecoration.underline)
                                            : textStyle),
                                  ))
                              .toList(),
                        )
                      : GestureDetector(
                          onTap: (speaker as Speaker).id != null
                              ? () {
                                  Navigator.pushNamed(context, '/speakers',
                                      arguments: speaker);
                                }
                              : null,
                          child: Text(speaker.name,
                              style: (speaker as Speaker).id != null
                                  ? textStyle.copyWith(
                                      color: Colors.blue[800],
                                      decoration: TextDecoration.underline)
                                  : textStyle),
                        )
                ],
              ),
            if (schedulePart.subject != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(schedulePart.subject is List ? "Možnosti:" : "Téma:",
                      style: textStyle),
                  Flexible(
                      child: Text(
                    schedulePart.subject is List
                        ? (schedulePart.subject as List<dynamic>).join("\n")
                        : schedulePart.subject,
                    style: textStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ))
                ],
              ),
          ],
        ));
  }
}
