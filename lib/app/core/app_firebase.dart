import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// handy call ~
final db = FirebaseFirestore.instance;
final analytic = FirebaseAnalytics.instance;
final crash = FirebaseCrashlytics.instance;

// ------------------------------------------------------------------------
// FireStore Collections Name
// ------------------------------------------------------------------------
const topics = 'topics';
const quizBank = 'quiz-bank';

// ------------------------------------------------------------------------
// Analytics
// ------------------------------------------------------------------------
Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
  await analytic.logEvent(name: name, parameters: parameters);
}
