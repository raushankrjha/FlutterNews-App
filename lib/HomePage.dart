import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'CardWidget.dart';
import 'CategoryNews.dart';
import 'NewsDetailsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading;
  List data;

  bool isDarkThemeEnable = false;
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
        title: Text("Top Headlines"),
      ),
      drawer: drawerWidget(),
      body: _bodyWidget(context),
    );
  }

  Widget drawerWidget() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Raushan jha"),
            accountEmail: Text("raushanjha465@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                "RJ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
          ),
          ListTile(
              title: Text("Sports"),
              leading: Icon(Icons.sports),
              onTap: () => navigateToCategory(context, 'sports')),
          ListTile(
              title: Text("Entertainment"),
              leading: Icon(Icons.movie),
              onTap: () => navigateToCategory(context, 'entertainment')),
          ListTile(
              title: Text("Science"),
              leading: Icon(Icons.golf_course),
              onTap: () => navigateToCategory(context, 'science')),
          ListTile(
              title: Text("Technology"),
              leading: Icon(Icons.send_to_mobile),
              onTap: () => navigateToCategory(context, 'technology')),
          Divider(),
          ListTile(
            title: Text("Close"),
            leading: Icon(Icons.close),
            onTap: () => Navigator.of(context).pop(),
          ),
          Divider(),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Setting",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          ListTile(
            title: Text("Dark Theme"),
            trailing: Switch(
              value: this.isDarkThemeEnable,
              onChanged: (bool value) => this.setTheme(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget(context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Featured News!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              sliderWidget(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Headlines!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              topHeadlineWidget(),
            ],
          );
  }

  Widget topHeadlineWidget() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
            child: CardWidget(data[index]['title'], data[index]['content'],
                data[index]['source']['name'], data[index]["urlToImage"]));
      },
    );
  }

  Widget sliderWidget() {
    return Container(
        child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int itemIndex, _) {
              return Container(
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Image.network(
                          data[itemIndex]["urlToImage"],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) =>
                              progress == null
                                  ? child
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      padding: EdgeInsets.all(30),
                                      child: CircularProgressIndicator()),
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Center(child: Text('No Image'));
                          },
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 120),
                        height: 80,
                        color: Colors.black38,
                        alignment: Alignment.center,
                        child: Text(
                          data[itemIndex]["title"],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ],
                ),
              );
            }));
  }

  Future fetchdata() async {
    var response = await http.get(
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=d6813f30acc2434d9516bfd5da8cfeb2");
    print(response.body);
    var converdata = json.decode(response.body);
    setState(() {
      data = converdata['articles'];
      isLoading = false;
    });
  }

  navigateToCategory(context, String categoryName) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CategoryNews(categoryName)));
  }

  void setTheme(bool value) {
    setState(() {
      this.isDarkThemeEnable = !this.isDarkThemeEnable;
    });

    DynamicTheme.of(context)
        .setBrightness(isDarkThemeEnable ? Brightness.dark : Brightness.light);
    DynamicTheme.of(context)
        .setThemeData(isDarkThemeEnable ? ThemeData.dark() : ThemeData.light());
  }
}
