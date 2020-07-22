import 'package:auto_type/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AutoComplete Flutter'), centerTitle: true),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                cursorColor: Colors.white,
                autofocus: true,
                style: TextStyle(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(border: OutlineInputBorder())),
            suggestionsCallback: (pattern) async {
              return await BackendService.getSuggestions(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(suggestion['name']),
                subtitle: Text('\$${suggestion['price']}'),
              );
            },
            onSuggestionSelected: (suggestion) {
              return Container(
                child: Text(suggestion['name']),
              );
            },
          ),
        ),
      ),
    );
  }
}
