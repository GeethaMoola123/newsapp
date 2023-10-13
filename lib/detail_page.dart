import 'package:flutter/material.dart';
import 'package:newsapp/detail_page.dart';

class DetailPage extends StatefulWidget {
  String imgaddress;
  String desc;
  String title;

   DetailPage({super.key,required this.imgaddress, required this.desc, required this.title});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25)
            ),
            child: Image.network(widget.imgaddress),
          ),
          SizedBox(height: 30),
          Text("${widget.title}"),
          SizedBox(height: 30),
          Text("${widget.desc}"),
        ],
      ),
    );
  }
}
