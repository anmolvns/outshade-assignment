import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Outshade Digital Media',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController age;
  late TextEditingController gender;
  List _items = [];

  String name = '';
  String id = '';
  String atype = '';

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response.toString());
    setState(() {
      _items = data["users"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
    age = TextEditingController();
    gender = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    age.dispose();
    gender.dispose();
  }

  Future openDialog(BuildContext context, String name) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter your details ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Enter your age'),
                  controller: age,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Enter your gender'),
                  controller: gender,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(context),
                      child: Text('Cancel'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        _submit(
                          context,
                        );
                      },
                      child: Text('Submit'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  void _submit(BuildContext context) {
    // Navigator.of(context).pop(context);
    String stage = age.text;
    String stgender = gender.text;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(
                a: stage,
                g: stgender,
                n: name,
              ),
          settings: RouteSettings(arguments: _items)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Outshade Digital Media',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(_items[index]["id"].toString()),
                          margin: const EdgeInsets.all(10),
                          color: Colors.amber.shade100,
                          child: ListTile(
                            leading: Text(id = _items[index]["id"].toString()),
                            title:
                                Text(name = _items[index]["name"].toString()),
                            subtitle:
                                Text(atype = _items[index]["atype"].toString()),
                            trailing: ElevatedButton(
                              child: const Text('Sign in'),
                              // foregroundColor: Colors.white,
                              // backgroundColor: Colors.amber.shade200,
                              // focusColor: Colors.amber.shade50,
                              onPressed: () async {
                                openDialog(context, name);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String a;
  final String g;
  final String n;
  const ProfileScreen(
      {super.key, required this.a, required this.g, required this.n});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Outshade Digital Media',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(10),
                color: Colors.amber.shade100,
                child: ListTile(
                  // leading: Text(a),
                  title: Text(n),

                  subtitle: Text('Age : $a, Gender : $g'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
