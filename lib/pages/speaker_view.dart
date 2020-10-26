import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'types.dart';

class SpeakerView extends StatelessWidget {
  SpeakerView(this.speakerData);

  final Speaker speakerData;

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

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
                  if (speakerData.photoURL != null)
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: speakerData.photoURL,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(speakerData.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(fontWeight: FontWeight.bold))),
                  if (speakerData.description != null)
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 4,
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            speakerData.description,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.justify,
                          ),
                        )),
                  if (speakerData.url != null)
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Material(
                            color: Color.fromRGBO(255, 255, 255, 0),
                            child: GestureDetector(
                                onTap: () {
                                  launchURL(speakerData.url);
                                },
                                child: Text(
                                  'Ostatní kázání',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(
                                          fontSize: 20,
                                          decoration: TextDecoration.underline),
                                ))))
                ],
              ),
            )));
  }
}
