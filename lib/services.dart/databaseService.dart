import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taradventapp/models/advent.dart';
import 'package:taradventapp/models/adventCase.dart';
import 'package:taradventapp/services.dart/authService.dart';
import 'package:taradventapp/services.dart/jsonDecode.dart';

class DatabaseService {
  //the firestore collection where all the advents are stored

  static Advent? advent;
  static String? code;

  final CollectionReference adventCollection =
      FirebaseFirestore.instance.collection("advents");

  Future<bool> getAdvent(String _code) async {
    User? user = AuthService().getCurrentUser;
    //Signing in anon just to make the firebase server a bit less attack open
    if (user == null) {
      await AuthService().signInAnon();
    }

    DocumentSnapshot snapshot = await adventCollection.doc(_code).get();
    //checking if an advent with code exists
    if (!snapshot.exists) {
      print('doesnt exist');
      return false;
    } else {
      print('getting code');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('code', _code);
      code = _code;
      advent = _adventFromSnapshot(
          snapshot as DocumentSnapshot<Map<String, dynamic>>);
      return true;
    }
  }

  Future openDay(int day) async {
    int index = advent!.adventCases.indexWhere((element) => element.day == day);
    advent!.adventCases[index].isOpeneded = true;
    await adventCollection
        .doc(code)
        .update({'adventCases': jsonEncode(advent!.adventCases)});
  }

  Future closeAll() async {
    for (var advenCase in advent!.adventCases) {
      advenCase.isOpeneded = false;
    }
    await adventCollection
        .doc(code)
        .update({'adventCases': jsonEncode(advent!.adventCases)});
  }

  Advent _adventFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Advent(
        adventCases: convertJsonToAdventCase(snapshot.data()!['adventCases']),
        title: snapshot.data()!['title'],
        fromWho: snapshot.data()!['fromWho']);
  }
}
