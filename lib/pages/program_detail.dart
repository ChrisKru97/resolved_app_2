import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'types.dart';

class ProgramDetail extends StatelessWidget {
  ProgramDetail(this.scheduleData);

  final SchedulePart scheduleData;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0.9),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(scheduleData.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(fontWeight: FontWeight.bold))),
                  if (scheduleData.info != null)
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 4,
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            scheduleData.info,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.justify,
                          ),
                        )),
                ],
              ),
            )));
  }
}
