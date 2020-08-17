import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage>{

  static var _categories=['IT','EEE'];
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),


      ),
    );
  }
}