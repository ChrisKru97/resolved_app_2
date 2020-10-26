import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resolved/pages/program_screen.dart';
import 'package:resolved/pages/types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/contacts.dart';
import 'pages/menu.dart';
import 'pages/program_detail.dart';
import 'pages/speaker_view.dart';
import 'pages/speakers.dart';
import 'pages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Speaker> speakers = [];
  final List<Day> days = [];
  final List<Contact> contacts = [];

  Future<void> loadSpeakersFromFS() async {
    final speakersDocs =
        await FirebaseFirestore.instance.collection('speakers').get();
    for (QueryDocumentSnapshot element in speakersDocs.docs) {
      speakers.add(Speaker.fromObject(element.data(), element.id));
    }
    (await SharedPreferences.getInstance())
        .setString("speakers", jsonEncode(speakers));
  }

  Future<void> loadDaysFromFS() async {
    final daysDocs = await FirebaseFirestore.instance
        .collection('schedule')
        .orderBy('time')
        .get();
    for (QueryDocumentSnapshot element in daysDocs.docs) {
      final Timestamp time = element.data()['time'];
      final String dateTitle = parseDateTitle(time.toDate());
      final SchedulePart schedulePart =
          SchedulePart.fromObject(element.data(), element.id);
      bool found = false;
      days.forEach((day) {
        if (dateTitle == day.title) {
          day.schedule.add(schedulePart);
          found = true;
        }
      });
      if (!found) {
        days.add(Day(dateTitle, [schedulePart]));
      }
    }
    (await SharedPreferences.getInstance()).setString("days", jsonEncode(days));
  }

  Future<void> loadContactsFromFS() async {
    final contactsDocs =
        await FirebaseFirestore.instance.collection('contacts').get();
    for (QueryDocumentSnapshot element in contactsDocs.docs) {
      contacts.add(Contact.fromObject(element.data(), element.id));
    }
    (await SharedPreferences.getInstance())
        .setString("contacts", jsonEncode(contacts));
  }

  Future<void> loadContent() async {
    await Firebase.initializeApp();
    final prefs = await SharedPreferences.getInstance();
    final cacheTimestamp = prefs.getInt("cacheTimestamp");

    if (cacheTimestamp == null ||
        DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(cacheTimestamp))
                .inHours >
            24) {
      await Future.wait(
          [loadContactsFromFS(), loadSpeakersFromFS(), loadDaysFromFS()]);
      prefs.setInt("cacheTimestamp", DateTime.now().millisecondsSinceEpoch);
    } else {
      speakers.addAll((jsonDecode(prefs.getString("speakers")) as List<dynamic>)
          .map((entry) => Speaker.fromJson(entry)));
      days.addAll((jsonDecode(prefs.getString("days")) as List<dynamic>)
          .map((entry) => Day.fromJson(entry)));
      contacts.addAll((jsonDecode(prefs.getString("contacts")) as List<dynamic>)
          .map((entry) => Contact.fromJson(entry)));
    }
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/menu':
        return CupertinoPageRoute(builder: (_) => Menu());
      case '/contacts':
        return CupertinoPageRoute(builder: (_) => Contacts(contacts));
      case '/upcoming':
        if (settings.arguments != null)
          return CupertinoPageRoute(
              builder: (_) => ProgramDetail(settings.arguments));
        return CupertinoPageRoute(
            builder: (_) => ProgramScreen(days, speakers));
      case '/speakers':
        if (settings.arguments != null)
          return CupertinoPageRoute(
              builder: (_) => SpeakerView(settings.arguments));
        return CupertinoPageRoute(builder: (_) => Speakers(speakers));
      default:
        return CupertinoPageRoute(builder: (_) => WelcomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    loadContent();
    return MaterialApp(
      title: 'Konference Resolved',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}
