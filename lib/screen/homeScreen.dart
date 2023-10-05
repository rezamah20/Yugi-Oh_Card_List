import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../model/allcard.dart';
import 'allCard.dart';

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

  @override
  void initState() {
    super.initState();
    _IsSearching = false;

  }

  @override
  Widget build(BuildContext context) {
    Widget? child;
    void titleselected(){
      switch (_index) {
        case 0:
          child = AllCard(key: UniqueKey(), crd: card);
          title = "Yugi-oh Card List";
          break;
        case 1:
          monster = card
              .where((Cards cards) => cards.type!.toString().toLowerCase()
              .contains("monster"))
              .toList();
          child = AllCard(key:UniqueKey(), crd: monster);
          title = "Monster Card";
          print("Monster Card");
          break;
        case 2:
          monster = card
              .where((Cards cards) => cards.type!.toString().toLowerCase()
              .contains("spell"))
              .toList();
          child = AllCard(key:UniqueKey(), crd: monster);
          title = "Spell Card";
          print("Spell Card");
          break;
      }
    }
    return Scaffold(
      appBar: buildBar(context),
      body: SafeArea(
          child: FutureBuilder<List<Cards>>(
              future: statesServices.getData(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  card = snapshot.data!;
                  titleselected();
                  return SizedBox.expand(child: child);
                }else if(snapshot.hasError){
                  print(snapshot.error);
                  return Text('Error');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
      ),
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
        debugPrint('You just selected $selection');
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
              padding: EdgeInsets.only(top: 9), // add padding to adjust icon
              child: Icon(Icons.search, color: Colors.white,),
              ),
            )
          );
        }
      ),
    );
  }
}
