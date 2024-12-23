import 'package:dio/dio.dart';
import 'package:flashcards/injection_container.dart';
import 'package:flashcards/presentation/add_set.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List sets = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch data from the Django backend (GET request)
  Future<void> fetchData() async {
    try {
      final response = await getIt<Dio>().get("http://127.0.0.1:8000/eraSingleSeson/"); // Use the correct URL with a trailing slash
      if (response.statusCode == 201) { // MOCK - should be 200 in real scenario
        final data = response.data;
        setState(() {
          sets = data;
        });
      } else {
        print("An error occurred while fetching data");
      }
    } on DioException {
      print("An error occurred while fetching data");
    }
  }

  // Send data to the Django backend (POST request)
  Future<void> sendDataToDjango(Map<String, dynamic> data) async {
    try {
      final response = await getIt<Dio>().post(
        "/add-flashcard-set/",  // Django endpoint to accept POST request
        data: data,  // Data to send in the POST request
      );

      if (response.statusCode == 201) {
        print("Data sent successfully: ${response.data}");
      } else {
        print("An error occurred while sending data");
      }
    } on DioException catch (e) {
      print("Error: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            "Twoje zestawy",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        actions: [
          IconButton.filled(
            onPressed: () {
              // Navigate to AddSet screen when pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddSet()),
              );
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 50),
        ],
        leadingWidth: 300,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromRGBO(28, 28, 28, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ListView.separated(
          itemCount: sets.isEmpty ? 0 : sets.length,  // Adjust to use actual length
          separatorBuilder: (context, index) => const Divider(
            color: Colors.purple,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 15),
            child: ListTile(
              title: Text(
                "Zestaw ${index + 1} - ${sets[index]["Player"]}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
              onTap: () {
                // When tapping on a set, send data to Django (POST request)
                Map<String, dynamic> flashcardSetData = {
                  "Player": sets[index]["Player"],  // Example player data
                  "setName": "Set ${index + 1}",    // Example set name
                };

                // Call the sendDataToDjango function to send the data
                sendDataToDjango(flashcardSetData);
              },
            ),
          ),
        ),
      ),
    );
  }
}
