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

  Future<void> fetchData() async {
    try {
      final response = await getIt<Dio>().get("/eraSingleSeson"); //MOCK

      if (response.statusCode == 201) { //MOCK - should be 200
        final data = response.data;
        setState(() {
          sets = data;
        });
      } else {
        print("An error occured");
      }
    } on DioException {
      print("An error occured");
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddSet()));
              },
              icon: const Icon(Icons.add)),
          const SizedBox(
            width: 50,
          )
        ],
        leadingWidth: 300,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromRGBO(28, 28, 28, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ListView.separated(
            itemCount: sets.isEmpty ? 0 : 5, //MOCK
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.purple,
                ),
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Zestaw ${index + 1} - ${sets[index]["Player"]}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                )),
      ),
    );
  }
}
