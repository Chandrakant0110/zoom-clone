import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_ui/resources/firestore_methods.dart';

class HistroyMeetingScreen extends StatelessWidget {
  const HistroyMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreMethods().meetingsHistory,
      builder: ((context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context ,index) => ListTile(
          title: Text('Room Name : ${(snapshot.data! as dynamic).docs[index]['meetingName']}'),
          subtitle: Text('Joined On : ${DateFormat.yMMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate(),)}'),
        ));

      } ),
    );
  }
}