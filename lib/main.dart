import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchVisual(),
    );
  }
}

class SearchVisual extends StatefulWidget {
  @override
  _SeachVisualState createState() => _SeachVisualState();
}

class _SeachVisualState extends State<SearchVisual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        actions: <Widget>[ 
          // klik search 
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> { 
  // data the citiy
  final cities = [
    "Bhandup",
    "Mumbai",
    "Visakhapatham",
    "Coimbatore",
    "Delhi",
    "Bengalore",
    "Pune",
    "Nagpur",
    "Lucknow",
    "Vadodara",
    "Indore",
    "Jalalpur",
    "Bhopal",
    "Kolkata",
    "Kanpur",
    "New Delhi",
    "Faridabad",
    "Rajkot",
    "Ghaziabad",
    "Chennai",
    "Meerut",
    "Agra",
    "Jaipur",
    "Varanasi",
    "Allahabad",
    "Hyderabad",
    "Noida",
    "Howrah",
    "Thane"
  ];

  final recentCities = ["New Delhi", "Faridabad", "Rajkot", "Ghaziabad"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // action for apps bar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        // ketika klik clean maka hapus query 
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon( 
        // ketika klik button kembali 
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the app 
    return Center(
          child: Container(  
            // menampilkan data yang akan di cari 
        width: 100.0, 
        height: 100.0,
            child: Card( 
          color: Colors.red, 
          shape: StadiumBorder(), 
          child: Center( 
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone search for somthing
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile( 
        onTap:(){ 
          showResults(context);
        },
        leading: Icon(Icons.location_city), 
        // set text span ketika data akan di search
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [TextSpan( 
                text: suggestionList[index].substring(query.length), 
                style: TextStyle(color: Colors.grey)
              )]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
