import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'bloc.dart';
import './../models/user.dart';
import './../clients/users_client.dart';

class UserBloc implements Bloc {
  final _controller = StreamController<User>();
  final _client = UsersClient();

  Stream<User> get userStream => _controller.stream;

  void find(String id) async {
    final DocumentSnapshot snapshot = await _client.fetch(id);
    _controller.sink.add(User.fromDocumentSnapshot(snapshot));
  }

  void getFromPhoneNumber() async {
    DocumentSnapshot snapshot = await _client.findFromPhoneNumber();

    if (snapshot.exists) {
      find(snapshot.documentID);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
