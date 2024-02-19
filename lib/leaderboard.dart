// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  int index = 1;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> a =
      FirebaseFirestore.instance.collection('TopScorers').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('TopScorers')
          .orderBy("score", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();

        return Scaffold(
          appBar: AppBar(
            
            actions: const [Icon(Icons.leaderboard)],
            title: const Text('Leaderboard'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children:
                  snapshot.data!.docs.map((data) => build_tile(data)).toList(),
            ),
          ),
        );
      },
    );
  }

  Padding build_tile(DocumentSnapshot snapshot) {
    return Padding(
      // key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          // title: Text(snapshot['name'], style: TextStyle(fontSize: 18),),
          // trailing: Text(snapshot['score'].toString(), style: TextStyle(fontSize: 20),),
          // onTap: () => print(snapshot['name']),

          leading: CircleAvatar(
            child: Text((index++).toString()),
          ),
          title: Text(
            snapshot['name'],
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            snapshot['score'].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
