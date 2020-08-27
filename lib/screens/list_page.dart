import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  dynamic data;
  Firestore _fireStoreDataBase = Firestore.instance;


  Future<dynamic> getData() async {

    final DocumentReference document =   Firestore.instance.collection("general").document('IT');

    /*await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });*/
  }

  @override
  void initState() {

    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List'),
        ),



       body: StreamBuilder(
         stream: Firestore.instance.collection('test').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           return ListView(
             scrollDirection: Axis.vertical,
             children: snapshot.data.documents.map((document) {
               return Card(
                 elevation:5,
                 margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(0.0),
                 ),
                    child: Column(
                      children: <Widget>[
                        ListTile(

                    title: Text("Post: " + document['name']),
                 subtitle: Text("Comapny: " + document['company']),


               ),
                        Divider(),
                        ListTile(
                          title: Text("Type: " +document['type']),

                        ),

                      ],
                    ),

               );
             }).toList(),
           );


         },

       ),

    );
  }
}