import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/bannerCard.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
import 'allCard.dart';
import 'detailCard.dart';

class HomeScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Yugi-oh card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(title: 'Yugi-oh Card List'),
    );
  }
}

class HomeScreen extends StatefulWidget{
  HomeScreen({Key? key, required this.title}) :super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _index = 0;
  var title = "";
  Widget? appBarTitle = Text("Yugi-oh Card List", style: TextStyle(color: Colors.white),);
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);
  final TextEditingController _searchQuery = TextEditingController();
  bool _IsSearching = false;
  String? _searchText = "";
  List<Cards> card = [];
  ApiService statesServices = ApiService();
  List<Cards> allcard = [];
  List<Cards> monster = [];
  List<Cards> spell = [];
  int currentIndex = 0;
  bool test = true;
  Widget? child;

  _HomeState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  void titleselected(){
    switch (_index) {
      case 0:
        test= true;
        child =  AllCard(crd: card);
        title = "Yugi-oh Card List";
        break;
      case 1:
        test= false;
        monster = card
            .where((Cards cards) => cards.type!.toString().toLowerCase()
            .contains("monster"))
            .toList();
        child = AllCard(key:UniqueKey(), crd: monster);
        title = "Monster Card";
        print("Monster Card");
        break;
      case 2:
        test= false;
        spell = card
            .where((Cards cards) => cards.type!.toString().toLowerCase()
            .contains("spell"))
            .toList();
        child = AllCard(key:UniqueKey(), crd: spell);
        title = "Spell Card";
        print("Spell Card");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: SafeArea(
          child: view(test,child)),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) {
          setState(() {
            _index = newIndex;
            titleselected();
            appBarTitle = Text(title, style: const TextStyle(color: Colors.white),);
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: "All Card"),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              label: "Monster Card"),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_3),
              label: "Spell Card"),
        ],
      ),
    );
  }

  Widget view(bool homepage, Widget? child){
    if(homepage == true){
      if(card.isEmpty){
        return FutureBuilder<List<Cards>>(
            future: statesServices.getData(),
            builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                card = snapshot.data!;
                titleselected();
                return SizedBox.expand(child: Homepage());
              }else if(snapshot.hasError){
                print(snapshot.error);
                return Text('Error');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        );
      }else{
        return SizedBox.expand(child: Homepage());
      }
     // print("true");
      //return SizedBox.expand(child: child,);
    }else{
     // print("false");
      return SizedBox.expand(child: child);
    }
  }
  var imgList = [
    {
      "url": 'https://images.ygoprodeck.com/images/sets/MP23.jpg',
      "id": "25th Anniversary Tin: Dueling Heroes Mega Pack"
    },
    {
      "url": 'https://images.ygoprodeck.com/images/sets/WISU.jpg',
      "id": "Wild Survivors"
    },
    {
      "url": 'https://images.ygoprodeck.com/images/sets/MP22.jpg',
      "id": "2022 Tin of the Pharaoh's Gods"
    },
    {
      "url": 'https://images.ygoprodeck.com/images/sets/MP20.jpg',
      "id": "2020 Tin of Lost Memories Mega Pack"
    },
  ];

  Widget Homepage(){
    CarouselController controller = CarouselController();
    monster = card
        .where((Cards cards) => cards.type!.toString().toLowerCase()
        .contains("monster"))
        .toList();
    return Column(
      children: <Widget>[
        Expanded(
          child: CarouselSlider(
          carouselController: controller,
          items: imgList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i["url"]!, fit: BoxFit.fill),
                        onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => BannerCardItem(title: i['id']!)));
                        }));
                    },
                );
              }).toList(), options: CarouselOptions(autoPlay: true,
              onPageChanged: (index, reason){
                setState(() {
                  currentIndex = index;
                  print(currentIndex);
                });
              },
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 0.8,
              initialPage: 2,),
            ),
        ),
        DotsIndicator(dotsCount: imgList.length, position: currentIndex.toDouble()),
        Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),child: const Text("All Card", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),)),
        Expanded(
          child: AllCard(crd: card),
        ),
      ],
    );
  }
  
  
  PreferredSizeWidget buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = _AsyncAutocomplete(card: card);
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },
          ),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle = new Text(title, style: new TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class _AsyncAutocomplete extends StatefulWidget {
  _AsyncAutocomplete({Key? key, required this.card}) :super(key: key);
  final List<Cards> card;

  @override
  _AsyncAutocompleteState createState() => _AsyncAutocompleteState(card: card);
}

class _AsyncAutocompleteState extends State<StatefulWidget> {
  _AsyncAutocompleteState({required this.card});
  final List<Cards> card;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Autocomplete<Cards>(
      optionsBuilder: (TextEditingValue textEditingValue) {// if user is input nothing
        if (textEditingValue.text == '') {
          return const Iterable<Cards>.empty();
        }
        return card
            .where((Cards cards) => cards.name!.toString().toLowerCase()
            .startsWith(textEditingValue.text.toLowerCase()))
            .toList();
      },
      onSelected: (Cards selection) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardDetailPage(key: UniqueKey(), cardname: selection.toString(),)));
      },
      fieldViewBuilder: ((context,
          textEditingController,
          focusNode,
          onFieldSubmitted) {
        return TextFormField(
          style: TextStyle(
            color: Colors.white,
          ),
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: onFieldSubmitted,
          decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 17), // add padding to adjust text
              isDense: true,
              hintText: "Search ..",
              hintStyle:TextStyle(color: Colors.white),
              prefixIcon: Padding(
              padding: EdgeInsets.only(top: 5), // add padding to adjust icon
              child: Icon(Icons.search, color: Colors.white,),
              ),
            )
          );
        }
      ),
    );
  }
}
