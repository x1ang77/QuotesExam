import 'package:flutter/material.dart';
import 'package:quiz_id_flutter/api/quotes_api.dart';
import 'package:quiz_id_flutter/model/quotes_model.dart';
import 'package:quiz_id_flutter/screens/individual.dart';
import 'package:quiz_id_flutter/screens/show_all.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuotesApi quotesApi = QuotesApi();
  Quotes? currentQuote;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInitialQuote();
  }

  void fetchInitialQuote() async {
    try {
      List<Quotes> quotes = await quotesApi.getQuotes();
      setState(() {
        currentQuote = quotes.first;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Failed to fetch quotes: $error');
    }
  }

  void fetchNewQuote() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Quotes> quotes = await quotesApi.getQuotes();
      setState(() {
        currentQuote = (quotes..shuffle()).first;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Failed to fetch quotes: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 330,
              height: 330,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: InkWell(
                onTap: () {
                  if (!isLoading && currentQuote != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Individual(quotes: currentQuote!),
                      ),
                    );
                  }
                },
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      : Text(
                          currentQuote!.quote,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: fetchNewQuote,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text(
                    'Refresh',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShowAll()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text(
                    'Show All',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
