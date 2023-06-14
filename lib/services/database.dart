import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/user_data.dart';
import 'package:firebase/screens/home/home_widgets/brew_model.dart';

class DatabaseService {
  DatabaseService({this.uid = ''});

  final CollectionReference _brewCollection =
      FirebaseFirestore.instance.collection('brews');

  String uid;

  Future updateUser(String sugars, String name, int strength) async {
    return await _brewCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  List<Brew> _brewListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Brew(
              name: doc.get('name'),
              sugars: doc.get('sugars'),
              strength: doc.get('strength'),
            ))
        .toList();
  }

  Stream<List<Brew>> get brews {
    return _brewCollection.snapshots().map((_brewListFromSnapshots));
  }

  UserData _userDataFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  Stream<UserData> get userData {
    return _brewCollection.doc(uid).snapshots().map((_userDataFromDocumentSnapshot));
  }
}
