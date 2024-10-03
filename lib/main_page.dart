import 'package:flutter/material.dart';
import 'api_handler.dart';
import 'model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler = ApiHandler();
  late List<User> data = [];

  void getData() async {
    try {
      final newData = await apiHandler.getUserData();
      setState(() {
        data = newData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterApi"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: getData,
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(10),
        child: const Text('Refresh'),
      ),
      body: Column(
        children: [
          Expanded(
            child: data.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("${data[index].userId}"),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].address),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}