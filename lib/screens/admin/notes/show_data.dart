import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_page.dart';
import 'edit_screen.dart';
import 'package:shopping_app/services/database_service.dart';

class ShowdataPage extends StatelessWidget {
  const ShowdataPage({Key? key}) : super(key: key);

  navigation(BuildContext context, Widget next) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigation(context, AddPage());
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: firebaseFirestore.collection("notes").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext, int index) {
                final res = snapshot.data!.docs[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (v) {
                    DatabaseServices.delete(res.id);
                  },
                  child: Card(
                      child: ExpansionTile(
                    title: Text("${res["title"]}"),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("details: ${res["detail"]}"),
                      )
                    ],
                    leading: IconButton(
                      onPressed: () {
                        navigation(
                            context,
                            EditData(
                              id: res.id,
                              title: res['title'],
                              detail: res['detail'],
                            ));
                      },
                      icon: Icon(Icons.edit),
                    ),
                  )),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
