import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
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
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 0,
        childAspectRatio: 0.8,
      children: List.generate(card.length, (index) {
        var cardimage = card[index].card_images![0].img_url;
        return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero),),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.zero),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardDetailPage(key: UniqueKey(), cardname: card[index].name!),));
            },
            child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 7),
                      child: Image.network(cardimage!,
                        fit: BoxFit.fill,
                        width: 150,
                        height: 200,
                      ),
                    ),
                    Container(
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