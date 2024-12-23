// add_set.dart
import 'package:dio/dio.dart';
import 'package:flashcards/injection_container.dart';
import 'package:flashcards/presentation/home_page.dart';
import 'package:flashcards/presentation/common/my_form_field.dart';
import 'package:flutter/material.dart';
import 'second_screen.dart'; // Import the second screen here

class AddSet extends StatefulWidget {
  const AddSet({super.key});

  @override
  State<AddSet> createState() => _AddSetState();
}

class _AddSetState extends State<AddSet> {
  Map setData = {"name": "", "cards": []};
  Map<int, Map> cardsData = {};
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            "Dodaj nowy zestaw",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Zapisz"),
            onPressed: () async {
              formKey.currentState!.save();
              setData["cards"] =
                  cardsData.entries.map((entry) => entry.value).toList();

              try {
                final response = await getIt<Dio>()
                    .post("/api/add_flashcard_set/", data: setData);

                if (response.statusCode == 200) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                } else {
                  print("An error occured");
                }
              } on DioException {
                print("An error occured");
              }
            },
          ),
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
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: MyFormField(
                      name: "Nazwa zestawu",
                      customOnSaved: (newValue) {
                        setData["name"] = newValue;
                      },
                    )),
                    Expanded(child: Container())
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Divider(
                    color: Colors.purple,
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      10,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                                child: MyFormField(
                              name: "Pojęcie ${index + 1}",
                              customOnSaved: (newValue) {
                                if (cardsData[index] == null) {
                                  cardsData[index] = {"term": newValue};
                                } else {
                                  cardsData[index]!["term"] = newValue;
                                }
                              },
                            )),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: MyFormField(
                              name: "Definicja ${index + 1}",
                              customOnSaved: (newValue) {
                                if (cardsData[index] == null) {
                                  cardsData[index] = {"definition": newValue};
                                } else {
                                  cardsData[index]!["definition"] = newValue;
                                }
                              },
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the second screen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondScreen()),
                    );
                  },
                  child: const Text("Go to Second Screen"),
                ),
              ],
            )),
      ),
    );
  }
}
