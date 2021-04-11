import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String title, desc, source, imgUrl;
  CardWidget(this.title, this.desc, this.source, this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Row(
        children: [
          imgUrl == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.blueGrey,
                    width: 100,
                    height: 100,
                    child: Center(child: Text("No Image")),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) =>
                            progress == null
                                ? child
                                : Container(
                                    height: 100,
                                    width: 100,
                                    padding: EdgeInsets.all(30),
                                    child: CircularProgressIndicator()),
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Center(child: Text('No Image'));
                        },
                      )),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.7,
                  child: Container(
                    child: Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  source,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
