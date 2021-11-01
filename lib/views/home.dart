import 'package:flutter/material.dart';
import 'package:rick_morty/views/all_characters.dart';
import 'package:rick_morty/views/all_episodes.dart';
import 'package:rick_morty/views/all_locations.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

final _tabs = ['CHARACTERS', 'EPISODES', 'LOCATIONS'];

class MyHomePageState extends State<MyHomePage> {
  Future<void>? _launched;

  Future<void>? get toLaunch async => await _launched;
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.plus_one),
        // ),
        appBar: AppBar(
          flexibleSpace: const Image(
              image: AssetImage('assets/background.png'), fit: BoxFit.cover),
          backgroundColor: Colors.transparent,
          //title: const Text('Rick & Morty'),
          actions: const [
            // ignore: curly_braces_in_flow_control_structures
            // ElevatedButton(
            //     onPressed: () {setState(() {
            //       _launched = _launchInBrowser(toLaunch);
            //     })},
            //     child:Icon(Icons.open_in_new)),
            //   ),
          ],
          bottom: TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.blueGrey,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.black),
            isScrollable: true,
            tabs: [
              for (final tab in _tabs)
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(tab),
                    ),
                  ),
                )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CharacterListView(),
            EpisodeListView(),
            LocationListView(),
            //FilteredCharacterListView(),
            //FilteredEpisodeListView(),
            //FilteredLocationListView(),
            //SpecifiedCharacterListView(),
            //SpecifiedEpisodeListView(),
            //SpecifiedLocationListView(),
          ],
        ),
      ),
    );
    //return MaterialApp(
    //  theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF2B2B2B)),
    //  debugShowCheckedModeBanner: false,
    //  home: Scaffold(
    //    appBar: AppBar(
    //      // Here we take the value from the MyHomePage object that was created by
    //      // the App.build method, and use it to set our appbar title.
    //      title: Text(widget.title),
    //      flexibleSpace: const Image(
    //        image: AssetImage('assets/background.jpg'),
    //        fit: BoxFit.cover,
    //      ),
    //      backgroundColor: Colors.transparent,
    //    ),
    //    body: const TabBarView(
    //      children: [
    //        CharacterListView(),
    //        // EpisodeListView(),
    //        // LocationListView(),
    //      ],
    //    ), // This trailing comma makes auto-formatting nicer for build methods.
    //  ),
    //);
  }
}
