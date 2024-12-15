import 'package:flashcards/presentation/home_page.dart';
import 'package:flashcards/presentation/common/my_form_field.dart';
import 'package:flutter/material.dart';

class AddSet extends StatelessWidget {
  const AddSet({super.key});

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
        actions: [ElevatedButton(
                  child: const Text("Zapisz"),
                  onPressed: () {Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const HomePage()));},
                ),
          const SizedBox(
            width: 50,
          )],
        leadingWidth: 300,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromRGBO(28, 28, 28, 1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: MyFormField("Nazwa zestawu")),
                Expanded(child: Container())
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Divider(color: Colors.purple,),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(child: MyFormField("Pojęcie ${index+1}")),
                      const SizedBox(width: 30,),
                      Expanded(child: MyFormField("Definicja ${index+1}"))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
