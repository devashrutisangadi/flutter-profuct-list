import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
 debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Products'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    var msg =" ";
    var productdata= [];
  @override

  void initState() {
    super.initState();
    apiCall();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(radius: 40,
          backgroundImage: NetworkImage(productdata[index]['images'][0]),),
          title: Text(productdata[index]['title'].toString()),
          subtitle: Text(productdata[index]['price'].toString()),
          trailing: Icon(Icons.arrow_right_sharp),
        );
      },
      itemCount: productdata.length,
      )
    );
  }
    void apiCall() async {
      var url = Uri.https('api.escuelajs.co', 'api/v1/products');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var mydata= jsonDecode(response.body);
      setState(() {
        productdata= mydata;
      });
    }
}