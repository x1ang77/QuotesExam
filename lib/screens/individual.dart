import 'package:flutter/material.dart';
import 'package:quiz_id_flutter/model/quotes_model.dart';

class Individual extends StatelessWidget {
  final Quotes quotes;
  const Individual({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // title:
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quote ID: ${quotes.id}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                width: 350,
                height: 250,
                padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey, width: 2.0),
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        quotes.quote,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 190.0),
                        child: Text(
                          quotes.author,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )),
                  ],
                )),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )));
  }
}
