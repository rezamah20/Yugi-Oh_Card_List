import 'package:flutter/material.dart';
import 'package:flutter_app/model/allcard.dart';

import '../api/ApiService.dart';
import '../utils/size_conf.dart';

class CardDetailPage extends StatefulWidget {
  final String cardname;

  CardDetailPage({Key? key, required this.cardname}) : super(key: key);

  @override
  _CardDetailPageState createState() => _CardDetailPageState(cardname: cardname, key: UniqueKey());
}

class _CardDetailPageState extends State<CardDetailPage> {
  _CardDetailPageState({Key? key, required this.cardname});

  final String cardname;


  ApiService statesServices = ApiService();
  List<DetailCards> card = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = cardname;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(title: Text(title)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<DetailCards>>(
              future: statesServices.getDetail(cardname),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  card = snapshot.data!;
                  return detail(context);
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
        ),
      ),
    );
  }

  Widget detail(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        cardImageContainer(),
        // Name
         NameContainer(),
        // Type
        TypeContainer(),
        DescContainer()
        // Race
        // spellRaceContainer(),
        // Archetype
        // spellArcheContainer(),
        // Desc
        // descContainer(),
        // Sets
        // setsContainer(),
      ],
    );
  }

  InkWell cardImageContainer() {
    var cardimage = card[0].detail_card_images![0].img_url;
    return InkWell(
      child: Padding(padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(cardimage!,
                fit: BoxFit.fill,
                width: SizeConfig.blockSizeVertical! * 35)
          ],
        )
      ),
    );
  }

  Container NameContainer() {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                card[0].name!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black12, width: 1, style: BorderStyle.solid)),
    );
  }

  Container TypeContainer() {
    var type =card[0].type!;
    var race;
    String level = "${card[0].level.toString()}   ";
    if(card[0].race != ""){race = card[0].race;};
    if(card[0].level == null){level = " ";}

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  CardLevelimg(),
                  Text(
                "$level$type/$race",
                //  textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),],)
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black12, width: 1, style: BorderStyle.solid)),
    );
  }

  Container DescContainer() {
    var desc =card[0].desc!;

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "[Description] \n \n $desc",
                      //  textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),],)
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black12, width: 1, style: BorderStyle.solid)),
    );
  }

  Container CardLevelimg(){
    return Container(height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Row(
        children: <Widget>[
        CardLevelImgAsset()
          ],
        ),
      );
  }

  Widget CardLevelImgAsset() {
    if (card[0].type?.toLowerCase() == "xyz monster"){
        return Image.asset('assets/images/lvl_xyz_monster.png');
    } else if(card[0].type?.toLowerCase() == "link monster"){
        return Image.asset('assets/images/lvl_link_monster.png');
    }else if(card[0].type?.toLowerCase() == "link monster"){
      return Image.asset('assets/images/lvl_link_monster.png');
    }else if(card[0].type!.toLowerCase().contains("spell") ){
      return Image.asset('assets/images/spell_logo.png');
    }else{
      return Image.asset('assets/images/lvl_monster.png');
    }
  }
}