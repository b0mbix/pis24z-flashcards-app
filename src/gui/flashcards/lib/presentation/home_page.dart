import 'package:flashcards/presentation/add_set.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddSet()));
              },
              icon: Icon(Icons.add)),
          SizedBox(
            width: 50,
          )
        ],
        leadingWidth: 300,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(28, 28, 28, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => Divider(
                  color: Colors.purple,
                ),
            itemBuilder: (context, index) => Text(
                  "Zestaw ${index + 1}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                )),
      ),
    );
  }
}
