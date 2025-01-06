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
  bool fetchSuccess = false;
  bool fetchFailure = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await getIt<Dio>().get("/api/flashcard-sets/all/");

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          sets = List.from(data);
          fetchSuccess = true;
        });
      } else {
        print("An error occurred while fetching data");
        setState(() {
          fetchFailure = true;
        });
      }
    } catch (e) {
      print("Error while fetching data: $e");
      setState(() {
        fetchFailure = true;
      });
    }
  }

  Widget displayPageContent() {
    if (fetchSuccess == false && fetchFailure == false) {
      return const Center(child: CircularProgressIndicator());
    } else if (fetchFailure) {
      return const Center(
        child: Text(
          "Nothing to display, an error occured.",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    } else if (fetchSuccess && sets.isEmpty) {
      return const Center(
        child: Text(
          "You don't have any sets yet. Add one using the button above.",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: sets.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.purple,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              sets[index]['name'],
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            "Your sets",
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
      backgroundColor: Color.fromRGBO(28, 28, 28, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: displayPageContent(),
      ),
    );
  }
}
