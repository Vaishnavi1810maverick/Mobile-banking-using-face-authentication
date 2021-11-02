import 'dart:convert';
import 'dart:io';
import '../home.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';

String val = " ";

class DataBaseService {
  // singleton boilerplate
  static final DataBaseService _cameraServiceService =
      DataBaseService._internal();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  factory DataBaseService() {
    return _cameraServiceService;
  }
  // singleton boilerplate
  DataBaseService._internal();

  // file that stores the data on filesystem
  File jsonFile;

  // Data learned on memory
  Map<String, dynamic> _db = Map<String, dynamic>();
  Map<String, dynamic> get db => this._db;

  // loads a simple json file.
  Future loadDB() async {
    var tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir.path + '/emb.json';

    jsonFile = new File(_embPath);

    if (jsonFile.existsSync()) {
      _db = json.decode(jsonFile.readAsStringSync());
    }
  }

  // [Name]: name of the new user
  // [Data]: Face representation for Machine Learning model
  Future saveData(String user, String password, List modelData) async {
    String userAndPass = user + ':' + password;
    _db[userAndPass] = modelData;
    //debugPrint(modelData);
    jsonFile.writeAsStringSync(json.encode(_db));
    print(userAndPass);
    return users
        .add({
          'user': user,
          'password': password,
          'model': modelData,
          'name': "Jane Doe",
          'cnum': '****  ****  ****  1234',
          'cvv': '123',
          'exp': '10/23',
          'transactions': '',
          'amount': ''
        })
        .then((value) => val = value.id)
        .catchError((error) => print("Failed to add user: $error"));
  }
}
