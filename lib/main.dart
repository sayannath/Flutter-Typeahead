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
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AutoComplete Flutter'), centerTitle: true),
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'What is your favorite city?',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: this._typeAheadController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'City')),
                    suggestionsCallback: (pattern) {
                      return BackendService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select a city';
                      }
                    },
                    onSaved: (value) => this._selectedCity = value,
                  ),
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Your Favorite City is ${this._selectedCity}')));
                  },
                )
              ]),
        ),
      ),
    );
  }
}
