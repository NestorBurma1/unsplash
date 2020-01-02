import 'package:flutter/material.dart';
import 'package:unsplash/models/image_model.dart';
import 'package:unsplash/providers/data_provaider.dart';
import 'package:unsplash/pages/full_image.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String isTitleEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<PhotoModel>>(
              future: DataProvider().getPhotoModel(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return const Center(
                    child: Text('Loading data...'),
                  );
                else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data[index].imageTitle != null) {
                        isTitleEmpty = snapshot.data[index].imageTitle;
                      } else
                        isTitleEmpty = 'No title';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                                child: Image.network(
                                    snapshot.data[index].imageUrlThumb),
                                onPressed: () {
                                  setState(
                                    () {
                                      Navigator.push<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (context) => FullImage(
                                              snapshot
                                                  .data[index].imageUrlFull),
                                        ),
                                      );
                                    },
                                  );
                                }),
                            Text(
                              isTitleEmpty,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(snapshot.data[index].authorName,
                                  style: const TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
