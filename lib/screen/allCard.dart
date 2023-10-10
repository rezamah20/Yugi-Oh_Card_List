import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
import '../utils/size_conf.dart';
import 'detailCard.dart';

class AllCard extends StatefulWidget{
  const AllCard({Key? key, required this.crd}) :super(key: key);
  final List<Cards> crd;
  @override
  _AllCard createState() => _AllCard(key: UniqueKey() ,card: crd);
}

class _AllCard extends State<AllCard> {
  _AllCard({this.key, required this.card});
  final Key? key;
  ApiService statesServices = ApiService();
  late final List<Cards> card;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _buildListView();
  }

  Widget _buildListView(){
    //_arguments = ModalRoute.of(context).settings.arguments;
    return ListView.builder(
        key: key,
        shrinkWrap:true,// -> Add this here
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: card.length,
        itemBuilder: (context, index) {
          var cardimage = card[index].card_images![0].img_url;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.zero),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardDetailPage(key: UniqueKey(), cardname: card[index].name!),));
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