import 'package:dio/dio.dart';
import 'package:flashcards/injection_container.dart';
import 'package:flashcards/presentation/home_page.dart';
import 'package:flashcards/presentation/common/my_form_field.dart';
import 'package:flutter/material.dart';

class AddSet extends StatefulWidget {
  const AddSet({super.key});

  @override
  State<AddSet> createState() => _AddSetState();
}

class _AddSetState extends State<AddSet> {
  Map<String, dynamic> setData = {"name": "", "cards": []};
  Map<int, Map<String, String>> cardsData = {};
  final formKey = GlobalKey<FormState>();
  bool startedSending = false;
  bool sentSuccessfully = false;

  Future<void> sendDataToDjango(Map<String, dynamic> data) async {
    try {
      setState(() {
        startedSending = true;
      });

      final response =
          await getIt<Dio>().post("/api/flashcard-sets/add/", data: data);

      if (response.statusCode == 201) {
        final setId = response.data["set_id"];

        for (var cardData in setData["cards"]) {
          if (cardData["term"] != "" && cardData["definition"] != "") {
            await getIt<Dio>().post("/api/flashcards/add/", data: {
              "set_id": setId,
              "question": cardData["term"],
              "answer": cardData["definition"]
            });
          }
        }

        setState(() {
          sentSuccessfully = true;
        });
      } else {
        print("An error occurred while sending data");
      }
    } catch (e) {
      print("Error while sending data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            "Add new set",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () async {
              formKey.currentState!.save();
              setData["cards"] =
                  cardsData.entries.map((entry) => entry.value).toList();
              setData["user_id"] = 1;

              sendDataToDjango(setData);
              if (startedSending && sentSuccessfully) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('An error occured. Try again.'),
                ));
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
                      name: "Set name",
                      customOnSaved: (newValue) {
                        setData["name"] = newValue;
                      },
                    )),
                    Expanded(child: Container())
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: MyFormField(
                      name: "Set description",
                      customOnSaved: (newValue) {
                        setData["descritpion"] = newValue;
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
                              name: "Term ${index + 1}",
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
                              name: "Definition ${index + 1}",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text("Go to back to Home page"),
                ),
              ],
            )),
      ),
    );
  }
}
