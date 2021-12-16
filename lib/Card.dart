import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model/model class.dart';

class Cardss extends StatefulWidget {
  const Cardss({Key? key}) : super(key: key);

  @override
  _CardssState createState() => _CardssState();
}


class _CardssState extends State<Cardss> {


  Future<Datta> getData()async
  {
    String url = "https://reqres.in/api/products?page=1";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Datta.fromJson(convert.jsonDecode(response.body));
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF32a8a8),
              Color(0xFF83c6de),
              Color(0xFFb2c0eb),
            ],
          )
      ),

      child: Scaffold(

          body: FutureBuilder<Datta>(
              future: getData(),
              builder: (context, snapshot) {
                List<Datum>array = snapshot.data!.data;
                if (snapshot.hasData) {} else if (snapshot.hasError) {
                  return ListView.builder(
                      itemCount: array.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Center(

                          child: Text(array[index].pantoneValue),

                        );

                      });
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}