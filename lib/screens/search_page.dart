import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage>{
  final GlobalKey<FormState> _formKeyValue=new GlobalKey<FormState>();
  List<String> _categoryName=<String>[
    'IT',
    'Telecom'
  ];


  @override
  Widget build(BuildContext context) {

    TextStyle textStyle=Theme.of(context).textTheme.title;

    var selectedType;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),

     body: Form(
       key: _formKeyValue,
         autovalidate: true,
       child: ListView(
         padding: EdgeInsets.symmetric(horizontal: 15.0),
         children: <Widget>[

           TextField(
             decoration: InputDecoration(
               icon: Icon(
                     FontAwesomeIcons.key,
               ),
               hintText: 'Enter Your Keyword',
               labelText: 'Keyword',

             ),
           ),

           SizedBox(height: 40.0,),

           DropdownButton(
                 items: _categoryName.map((value)=>DropdownMenuItem(
                   child: Text(
                     value,
                   ),
                   value: value,

                  )).toList(),
                 onChanged: (selectedCategoryType){
                   setState(() {
                     selectedType=selectedCategoryType;
                   });
                 },
                 value: selectedType,
                 hint: Text('Choose Category Type'),
               ),

           
           SizedBox(height: 40.0,),

           StreamBuilder<QuerySnapshot>(
             stream: Firestore.instance.collection('general').snapshots(),
             // ignore: missing_return
             builder: (context,snapshot){
               if(!snapshot.hasData) {
                 const Text("Loading");
                  return const Center(
                    child: const CupertinoActivityIndicator(),
                  );
                 //return Container(width: 0.0, height: 0.0);

               }
               else{
                 List<DropdownMenuItem> categoryItems=[];
                 for(int i=0;i<snapshot.data.documents.length;i++){
                   DocumentSnapshot snap=snapshot.data.documents[i];
                         categoryItems.add(
                           DropdownMenuItem(
                             child:Text(
                               snap.documentID,
                             ),
                             value: "${snap.documentID}",
                           ),
                         );
                 }

                 return Row(
                   children: <Widget>[
                     DropdownButton(
                       items: categoryItems,
                       onChanged: (categoryValue){
                         final snackBar = SnackBar(
                           content: Text(
                             'Selected Currency value is $categoryValue',

                           ),
                         );
                         Scaffold.of(context).showSnackBar(snackBar);
                         setState(() {
                           selectedType=categoryValue;
                         });

                       },
                       value: selectedType,
                       isExpanded: false,
                       hint: new Text(
                         "test"
                       ),
                     )
                   ],

                 );

               }
               },

           )




      ],
     ),

     )
    );
  }
}