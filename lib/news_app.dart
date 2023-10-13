import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:newsapp/detail_page.dart';
import 'news_model.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  Future<NewsModel> fetchNews() async {
    final url = "https://newsapi.org/v2/everything?q=tesla&from=2023-09-13&sortBy=publishedAt&apiKey=dff701224f0c446babc03da9c8955dcf";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return NewsModel.fromJson(result);
    }
    else {
      return NewsModel();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: FutureBuilder(future: fetchNews(), builder: (context, snapshot) {
        return ListView.builder(itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              var data=snapshot.data!.articles![index];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(imgaddress: data.urlToImage.toString(),desc: data.description.toString(),title: data.description.toString())));
            },
            leading: CircleAvatar(
              backgroundImage:snapshot.data!.articles![index].urlToImage!=null? NetworkImage("${snapshot.data!.articles![index].urlToImage}") :NetworkImage("https://portal.staralliance.com/cms/aux-pictures/prototype-images/avatar-default.png/@@images/image.png")
            ),
            title:snapshot.data!.articles![index].title!=null? Text("${snapshot.data!.articles![index].title}") :Text("Data Not Found!!"),
            subtitle:snapshot.data!.articles![index].description!=null? Text("${snapshot.data!.articles![index].description}") : Text("Description Not Found!!"),
          );
        },itemCount: snapshot.data!.articles!.length);
        },
      ),
    );
  }
}
