import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs/screens/search_page.dart';

void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/search': (BuildContext context) => new SearchPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text('My Jobs'),),
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.blue,
         child: Icon(Icons.search),
         onPressed: () => Navigator.of(context).pushNamed('/search')
       ),

       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

       bottomNavigationBar: BottomAppBar(
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             //We shall add two IconButtons here
             IconButton(icon: Icon(Icons.home),color: Colors.blue, onPressed: null),
             IconButton(icon: Icon(Icons.account_circle),color: Colors.white, onPressed: null),
           ],
         ),
         //now we shall add notch to the FAB
         shape: CircularNotchedRectangle(),
         color: Colors.blueGrey,
         //Voila!!!!! We are done. Just run the app and you shall get your Center Docked FAB!!!!
       ),
     );

  }
}

