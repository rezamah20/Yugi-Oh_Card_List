import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
import '../utils/size_conf.dart';
import 'detailCard.dart';

class BannerCardItem extends StatefulWidget{
  BannerCardItem({Key? key, required this.title}) :super(key: key);
  final String title;
  @override
  _BannerCardItem createState() => _BannerCardItem(key: UniqueKey() ,title: title);
}

class _BannerCardItem extends State<BannerCardItem> {
  _BannerCardItem({this.key, required this.title});
  final Key? key;
  ApiService statesServices = ApiService();
  final String title;
  List<BannerCard> card = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
          child: FutureBuilder <List<BannerCard>>(
              future: statesServices.getBannerCard(title),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  card = snapshot.data!;
                  return SizedBox.expand(child: _GridView());
                }else if(snapshot.hasError){
                  print(snapshot.error);
                  return Text('Error');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ))
    );
  }

  Widget _GridView(){
    final List<String> elements = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "A Million Billion Trillion", "A much, much longer text that will still fit"];

    return GridView.extent(
        maxCrossAxisExtent: 300.0,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 0.59,
        children: List.generate(card.length, (index) {
          var cardimage = card[index].card_images![0].img_url;
          return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardDetailPage(key: UniqueKey(), cardname: card[index].name!),));
                },
                child: Container(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 7),
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.network(cardimage!,
                                fit: BoxFit.fill,
                              ),
                            )
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              card[index].name!
                          ),
                        )
                      ],
                    )
                ),
              )
          );
        }),
    );
  }

  Widget test(){
   return GridView.count(
     crossAxisCount: 2,
     mainAxisSpacing: 0,
     crossAxisSpacing: 0,
     childAspectRatio: 0.7,
     children: List.generate(card.length, (index) {
       var cardimage = card[index].card_images![0].img_url;
       return Card(
           elevation: 10,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0),
           ),
           child: InkWell(
             onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardDetailPage(key: UniqueKey(), cardname: card[index].name!),));
             },
             child: Container(
                 padding: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 7),
                 child: Column(
                   children: <Widget>[
                     Container(
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(0.0),
                           child: Image.network(cardimage!,
                             fit: BoxFit.fill,
                             width: 150,
                             height: 200,
                           ),
                         )
                     ),
                     Container(
                       padding: const EdgeInsets.all(5.0),
                       child: Text(
                           card[index].name!
                       ),
                     )
                   ],
                 )
             ),
           )
       );
     }),
   );
  }
}