import 'package:flutter/material.dart';
import 'package:quiz_id_flutter/api/quotes_api.dart';
import 'package:quiz_id_flutter/model/quotes_model.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({super.key});

  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  late Future<List<Quotes>> futureQuotes;
  List<Quotes> allQuotes = [];

  @override
  void initState() {
    super.initState();
    futureQuotes = QuotesApi().getQuotes();
    futureQuotes.then((value) {
      setState(() {
        allQuotes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder<List<Quotes>>(
                    future: futureQuotes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text("Failed to load quotes."));
                      } else {
                        return ListView.builder(
                            itemCount: allQuotes.length,
                            itemBuilder: (context, index) {
                              return QuotesModel(quote: allQuotes[index]);
                            });
                      }
                    })),
            Container(
              padding: const EdgeInsets.fromLTRB(140, 5, 140, 5),
              color: Colors.white,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ));
  }
}
