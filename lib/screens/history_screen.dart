import 'package:chalet_sharks/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy/MM/dd');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('reservations').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final List<ReservationModel> reservations = snapshot.data!.size > 0 ? snapshot.data?.docs.map((e) => ReservationModel.fromJson(e.data()).copyWith(id: e.id)).toList() ?? [] : [];
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final item = reservations[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                  title: Text("from: ${formatter.format(item.reservationStart.toDate())}, to: ${formatter.format(item.reservationEnd.toDate())}"),
                  subtitle: Text("Created at: ${formatter.format(item.createdAt.toDate())}"),
                  trailing: IconButton(
                    onPressed: () => showDeleteDialog(context, item.id!),
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red.shade700,
                    ),
                  ), 
                ),
                Card(
                  child:Column(
                    children: [
                      Text("instructions",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      Text("you don't have to bring any pits",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      Text("Don't break any thing",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                )
                  ],
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

showDeleteDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm"),
        content: Text("Are you sure you want to delete this reservation?"),
        actions: <Widget>[
          TextButton(
            child: Text("No"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("Yes"),
            onPressed: () {
              FirebaseFirestore.instance.collection('reservations').doc(id).delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
