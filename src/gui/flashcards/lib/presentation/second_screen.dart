import 'package:flutter/material.dart';
import 'api_service.dart'; // Import your API service to fetch data

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Future<Map<String, dynamic>> _jsonData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _jsonData = apiService.fetchExampleData(); // Fetch data from Django
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Data Screen'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _jsonData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Message: ${data['message']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Status: ${data['status']}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Items: ${data['items'].join(', ')}', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
