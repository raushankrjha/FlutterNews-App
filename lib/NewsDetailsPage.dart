import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  String title, desc, source, date, imgUrl;
  NewsDetails(this.title, this.desc, this.source, this.date, this.imgUrl);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                widget.imgUrl == null
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: Center(child: Text("No Image")))
                    : Container(
                        height: 200,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: Image(
                          height: 200,
                          width: double.infinity,
                          image: NetworkImage(widget.imgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  height: 220,
                  padding: EdgeInsets.only(right: 8),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.source),
                      Text(
                        " " + widget.source,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textSelectionHandleColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range),
                      Text(
                        " ${this.formatDtae(widget.date)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textSelectionHandleColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                widget.desc,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  String formatDtae(String dateTime) {
    var date = DateTime.parse(dateTime);
    return "${date.day}-${date.month}-${date.year}";
  }
}
