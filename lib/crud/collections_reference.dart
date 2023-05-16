import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

getUser() => FirebaseAuth.instance.currentUser;

var user = FirebaseAuth.instance.currentUser;
var userId = FirebaseAuth.instance.currentUser!.uid;

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection("user_collection");

CollectionReference notesCollection =
    usersCollection.doc(userId).collection("Notes");

Stream<QuerySnapshot> notesStream = notesCollection.snapshots();
