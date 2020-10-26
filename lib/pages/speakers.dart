import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'types.dart';

class Speakers extends StatelessWidget {
  Speakers(this.speakers);

  final List<Speaker> speakers;

  @override
  Widget build(BuildContext context) {
    if (speakers.length == 0) {
      return Center(child: CircularProgressIndicator());
    }
    final textStyle =
        TextStyle(fontSize: MediaQuery.of(context).size.width / 20);
    final imageSize = MediaQuery.of(context).size.width / 6;
    return Material(
      child: ListView.builder(
          itemCount: speakers.length,
          itemBuilder: (_, index) {
            final speaker = speakers.elementAt(index);
            return InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                '/speakers',
                arguments: speaker,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.white : Colors.teal[100],
                  ),
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (index % 2 != 0)
                        Text(
                          speaker.name,
                          style: textStyle,
                        ),
                      CircleAvatar(
                        radius: imageSize / 2,
                        backgroundColor: Colors.green[300],
                        child: speaker.photoURL != null
                            ? ClipOval(
                                child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                width: imageSize,
                                height: imageSize,
                                imageUrl: speaker.photoURL,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ))
                            : null,
                      ),
                      if (index % 2 == 0)
                        Text(
                          speaker.name,
                          style: textStyle,
                        )
                    ],
                  )),
            );
          }),
    );
  }
}
