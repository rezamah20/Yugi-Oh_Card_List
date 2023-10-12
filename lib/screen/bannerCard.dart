import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
import '../utils/size_conf.dart';
import 'detailCard.dart';


class BannerCardItem extends StatelessWidget {
  BannerCardItem({this.key, required this.title});
  late final Key? key;
  final ApiService statesServices = ApiService();
  late final String title;
  late List<BannerCard> card = [];


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
                  return SizedBox.expand(child: _GridView(context));
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

  Widget _GridView(BuildContext context){

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
}