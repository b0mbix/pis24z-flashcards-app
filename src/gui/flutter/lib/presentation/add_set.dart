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
  Map<String, dynamic> setData = {};
  Map<int, Map<String, String>> cardsData = {};
  final formKey = GlobalKey<FormState>();
  bool sendSuccess = false;
  bool sendFailure = false;

  Future<void> sendDataToDjango(
      Map<String, dynamic> setData, List<Map<String, String>> cardsData) async {
    try {
      setState(() {
        sendSuccess = false;
        sendFailure = false;
      });

      final response =
          await getIt<Dio>().post("/api/flashcard-sets/add/", data: setData);

      if (response.statusCode == 201) {
        final setId = response.data["set_id"];

        for (var cardData in cardsData) {
          if (cardData["term"] != "" && cardData["definition"] != "") {
            await getIt<Dio>().post("/api/flashcards/add/", data: {
              "set_id": setId,
              "question": cardData["term"],
              "answer": cardData["definition"]
            });
          }
        }

        setState(() {
          sendSuccess = true;
        });
      } else {
        print("ERROR - Response status code != 201");
        setState(() {
          sendFailure = true;
        });
      }
    } on DioException catch (e) {
      print("ERROR - Dio error while sending data: $e");
      setState(() {
        sendFailure = true;
      });
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
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                setData["user_id"] = 0;
                await sendDataToDjango(setData,
                    cardsData.entries.map((entry) => entry.value).toList());
                if (sendSuccess!) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                } else if (sendFailure!) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('An error occured. Try again.'),
                  ));
                }
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
                      name: "Name",
                      customOnSaved: (newValue) {
                        setData["name"] = newValue;
                      },
                    )),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: MyFormField(
                      name: "Description",
                      customOnSaved: (newValue) {
                        setData["description"] = newValue;
                      },
                      nullable: true,
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
                              nullable: true,
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
                              nullable: true,
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
