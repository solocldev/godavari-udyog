import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maize_app/main.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key, this.snapShot}) : super(key: key);
  final snapShot;
  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: (MediaQuery.of(context).size.width) / 1,
      margin: EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width) / 1) /
            2,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/company_logo.png',
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.snapShot['owner'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Icon(Icons.more_horiz)
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                child: Text(widget.snapShot['title'],
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(widget.snapShot['sub_title'],
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            child: Image.network(widget.snapShot['img_url'], fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    if (prefs.getBool('${widget.snapShot['id']}') == null) {
                      FirebaseFirestore.instance
                          .collection('admins')
                          .doc(MyApp.uid)
                          .collection('posts')
                          .doc(widget.snapShot['id'])
                          .update({'likes': widget.snapShot['likes'] + 1});
                    }
                    prefs.setBool('${widget.snapShot['id']}', true);
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    size: 24.0,
                  ),
                  label: Text(widget.snapShot['likes'].toString()),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    Share.share('https://www.solocl.com',
                        subject: 'checkout solocl');
                  },
                  icon: Icon(
                    Icons.share,
                    size: 24.0,
                  ),
                  label: Text('Share'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
