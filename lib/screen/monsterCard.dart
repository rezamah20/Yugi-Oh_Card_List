

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
import '../utils/bottomNavBar.dart';
import '../utils/size_conf.dart';

class MonsterCard extends StatefulWidget{
  @override
  _MonsterCard createState() => _MonsterCard();
}

class _MonsterCard extends State<MonsterCard> {
  List<Cards> card = [];
  ApiService statesServices = ApiService();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<Cards>>(
              future: statesServices.getData(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  card = snapshot.data!;
                  return _buildListView();
                }else if(snapshot.hasError){
                  print(snapshot.error);
                  return Text('Error');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          )
      ),
    );
  }

  Widget _buildListView(){
    return ListView.builder(
        itemCount: card == null? 0: card.length,
        itemBuilder: (context, index) {
          var cardimage = card[index].card_images![0].img_url;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.zero),
              onTap: (){

              },
              child: Row(
                children: <Widget>[
                  Image.network(cardimage!,
                    fit: BoxFit.fill,
                    width: 150,
                    height: 200,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical! * 20,
                    width: SizeConfig.blockSizeHorizontal! * 60,
                    padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: Text(card[index].name!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2, bottom: 4),
                          child: Text(
                            card[index].type!,
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                        Expanded(
                            child: Text(card[index].desc!,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}