import 'package:cloud_firestore/cloud_firestore.dart';

class Speaker {
  Speaker(this.name);

  String name;
  String description;
  String photoURL;
  String url;
  String id;

  Speaker.fromObject(Map<String, dynamic> data, String id)
      : name = data['name'],
        description = data['description'],
        photoURL = data['photoURL'],
        url = data['url'],
        id = id;

  Speaker.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        photoURL = data['photoURL'],
        url = data['url'],
        id = data['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'photoURL': photoURL,
        'url': url,
        'id': id,
      };
}

class Contact {
  String name;
  String role;
  String number;
  String id;

  Contact.fromObject(Map<String, dynamic> data, String id)
      : name = data['name'],
        role = data['role'],
        number = data['number'],
        id = id;

  Contact.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        role = data['role'],
        number = data['number'],
        id = data['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'number': number,
        'id': id,
      };
}

class SchedulePart {
  String name;
  String place;
  dynamic subject;
  Timestamp time;
  dynamic speaker;
  String info;
  String id;

  SchedulePart.fromObject(Map<String, dynamic> data, String id)
      : name = data['name'],
        place = data['place'],
        subject = data['subject'],
        time = data['time'],
        info = data['info'],
        speaker = data['speaker'],
        id = id;

  SchedulePart.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        place = data['place'],
        subject = data['subject'],
        info = data['info'],
        time = Timestamp.fromMillisecondsSinceEpoch(data['time']),
        speaker = data['speaker'],
        id = data['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'place': place,
        'subject': subject,
        'time': time.millisecondsSinceEpoch,
        'info': info,
        'speaker': speaker,
        'id': id,
      };
}

class Day {
  Day(this.title, this.schedule);

  String title;
  List<SchedulePart> schedule;

  Day.fromJson(Map<String, dynamic> data)
      : title = data['title'],
        schedule = (data['schedule'] as List<dynamic>)
            .map((entry) => SchedulePart.fromJson(entry))
            .toList();

  Map<String, dynamic> toJson() => {
        'title': title,
        'schedule': schedule,
      };
}
