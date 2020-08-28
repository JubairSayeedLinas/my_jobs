
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_jobs/screens/list_page.dart';



class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage>{
  var selectedType,selectedSpecial, selectedLocation, selectedExp;
  final GlobalKey<FormState> _formKeyValue=new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    TextStyle textStyle=Theme.of(context).textTheme.title;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),


       body: Form(
         key: _formKeyValue,
           autovalidate: true,
         child: new ListView(
           padding: EdgeInsets.symmetric(horizontal: 15.0),
           children: <Widget>[

             new TextField(
               decoration: InputDecoration(
                 icon: Icon(
                       FontAwesomeIcons.key,
                 ),
                 hintText: 'Enter Your Keyword',
                 labelText: 'Keyword',

               ),
             ),

             SizedBox(height: 10.0,),
             StreamBuilder<QuerySnapshot>(
               stream: Firestore.instance.collection("general").snapshots(),
               // ignore: missing_return
               builder: (context, snapshot) {
                 if (!snapshot.hasData)
                   return Text("Loading.....");
                 else {
                   List<DropdownMenuItem> categoryItems = [];
                   for (int i = 0; i < snapshot.data.documents.length; i++) {
                     DocumentSnapshot snap = snapshot.data.documents[i];
                     categoryItems.add(
                       DropdownMenuItem(
                         child: Text(
                           snap.documentID,
                           style: TextStyle(color: Color(0xff11b719)),
                         ),
                         value: "${snap.documentID}",
                       ),
                     );
                   }
                   return Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10.0),
                               color: Colors.white,
                               border: Border.all()),
                           child: DropdownButtonHideUnderline(
                             child: DropdownButton(
                               items: categoryItems,
                               value: selectedType,
                               onChanged: (categoryValue){
                                 setState(() {
                                   selectedType=categoryValue;
                                 });
                                 print(selectedType);

                               },
                               //value: selectedType,
                               isExpanded: false,
                               hint: new Text("General Category"),

                             ),
                           ),
                         ),
                       )


                     ],

                   );

                 }
                 },

             ),


             SizedBox(height: 10.0,),
             StreamBuilder<QuerySnapshot>(
               stream: Firestore.instance.collection("special").snapshots(),
               // ignore: missing_return
               builder: (context, snapshot) {
                 if (!snapshot.hasData)
                   return Text("Loading.....");
                 else {
                   List<DropdownMenuItem> specialItems = [];
                   for (int i = 0; i < snapshot.data.documents.length; i++) {
                     DocumentSnapshot snap = snapshot.data.documents[i];
                     specialItems.add(
                        DropdownMenuItem(
                         child: Text(
                           snap.documentID,
                           style: TextStyle(color: Color(0xff11b719)),
                         ),
                         value: "${snap.documentID}",
                       ),
                     );
                   }


                   return Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10.0),
                               color: Colors.white,
                               border: Border.all()),
                           child: DropdownButtonHideUnderline(
                             child: DropdownButton(
                               items: specialItems,
                               value: selectedSpecial,
                               onChanged: (specialValue){
                                 setState(() {
                                   selectedSpecial=specialValue;
                                 });
                                 //print(selectedSpecial);

                               },

                               isExpanded: false,
                               hint: new Text("Special Category"),


                             ),
                           ),

                         ),

                       ),



                     ],


                   );

                 }
               },

             ),



             SizedBox(height: 10.0),
             Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: <Widget>[
                 RaisedButton(
                     color: Color(0xff11b719),
                     textColor: Colors.white,
                     child: Padding(
                         padding: EdgeInsets.all(10.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Text("Submit", style: TextStyle(fontSize: 24.0)),
                           ],
                         )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListPage(
                            selectedType: selectedType,
                            selectedSpecial: selectedSpecial,
                            selectedLocation: selectedLocation,
                            selectedExp: selectedExp,
                          )),
                        );
                      },
                     shape: new RoundedRectangleBorder(
                         borderRadius: new BorderRadius.circular(30.0))),
               ],
             ),




        ],


       ),



       )

      ),
    );
  }
}