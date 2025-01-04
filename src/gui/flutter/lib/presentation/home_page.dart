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
      final response = await getIt<Dio>().get("/api/flashcard_sets/all/");
      
      if (response.statusCode == 200) { 
        final data = response.data;

        if (data is List) {
          setState(() {
            sets = List.from(data);
          });
        } else {
          print("Unexpected data format: The response is not a List");
        }
      } else {
        print("An error occurred while fetching data");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }




  Future<void> sendDataToDjango(Map<String, dynamic> data) async {
    try {
      final response = await getIt<Dio>().post(
        "/add-flashcard-set/",  
        data: data, 
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
        padding: EdgeInsets.only(top: 40),
        child: sets.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: sets.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        print('${sets[index]['name']} selected');
                      },
                      child: Text(
                        sets[index]['name'],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}