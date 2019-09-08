import 'dart:async';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'bloc.dart';
import './../models/user.dart';
import './../clients/users_client.dart';

class UserBloc implements Bloc {
  final DocumentReference reference;

  UserBloc({@required this.reference}) : assert(reference != null);

  final _controller = StreamController<User>();
  final _client = UsersClient();

  Stream<User> get userStream => _controller.stream;

  void find() async {
    final DocumentSnapshot snapshot = await _client.findSnapshot(reference);
    _addUserFromSnapshot(snapshot);
  }

  void findStream() {
    _client.findSnapshotStream(reference).listen((DocumentSnapshot snapshot) {
      _addUserFromSnapshot(snapshot);
    });
  }

  void _addUserFromSnapshot(DocumentSnapshot snapshot) {
    _controller.sink.add(User.fromDocumentSnapshot(snapshot));
  }

  @override
  void dispose() {
    _controller.close();
  }
}
