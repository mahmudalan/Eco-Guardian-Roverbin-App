import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();
final dataSampah = database.child('dataSampah');