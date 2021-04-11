import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'CardWidget.dart';
import 'NewsDetailsPage.dart';

class CategoryNews extends StatefulWidget {
  final String category_name;
  CategoryNews(this.category_name);
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool isLoading;
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category_name.toUpperCase()),
      ),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsDetails(
                                data[index]['title'],
                                data[index]['content'],
                                data[index]['source']['name'],
                                 data[index]['publishedAt'],
                                data[index]["urlToImage"])));
                  },
                  child: CardWidget(
                      data[index]['title'],
                      data[index]['content'],
                      data[index]['source']['name'],
                      data[index]["urlToImage"]));
            },
          );
  }

  Future fetchdata() async {
    var response = await http.get(
        "http://newsapi.org/v2/top-headlines?country=in&category=" +
            widget.category_name +
            "&apiKey=d6813f30acc2434d9516bfd5da8cfeb2");
    print(response.body);
    var converdata = json.decode(response.body);
    setState(() {
      data = converdata['articles'];
      isLoading = false;
    });
  }
}
