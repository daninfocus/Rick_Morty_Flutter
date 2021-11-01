import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/src/models/all_characters.dart';
import 'package:rick_morty/src/models/episode.dart';
import 'package:rick_morty/src/providers/episode_provider.dart';
import '../globals.dart';

class CharacterListView extends StatefulWidget {
  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  var buttonColorActive = MaterialStateProperty.all<Color>(Colors.green);
  var buttonColorUnactive =
      MaterialStateProperty.all<Color>(Colors.green.shade900);
  bool activeButton1 = false;
  bool activeButton2 = true;
  static var rng = Random();
  var page = 1;

  var pageString = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<AllCharacters>(
        future: charactersClass.getAllCharacters(pageString),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Image(image: AssetImage('assets/loading.gif'));
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error Loading Data.'));
          } else {
            var characters = snapshot.data!.results;
            var totalPages = snapshot.data!.info.count;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: AlertDialog(
                                    backgroundColor: Colors.grey.shade900,
                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Positioned(
                                          right: -60.0,
                                          bottom: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const CircleAvatar(
                                              child: Icon(Icons.redo),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: FutureBuilder(
                                              future: EpisodeProvider()
                                                  .getEpisode(characters[index]
                                                      .episode
                                                      .first),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Episode>
                                                      snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const Image(
                                                    image: AssetImage(
                                                        'assets/loading.gif'),
                                                  );
                                                } else {
                                                  Episode? episode =
                                                      snapshot.data;
                                                  return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              const BoxShadow(
                                                                color: Colors
                                                                    .black54,
                                                                blurRadius: 1,
                                                                offset: Offset(
                                                                    1, 20),
                                                                spreadRadius: 1,
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150),
                                                          ),
                                                          child: Center(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          150),
                                                              child: Image(
                                                                  height: 200,
                                                                  image: NetworkImage(
                                                                      characters[
                                                                              index]
                                                                          .image)),
                                                            ),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  30.0),
                                                        ),
                                                        const Text('Name: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            characters[index]
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                        const Text('Status: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .status,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text('Species: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .species,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text('Type: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .type,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text('Gender: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .gender,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text(
                                                            'Origin Name: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .origin
                                                                  .name,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text(
                                                            'Location Name: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .location
                                                                  .name,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text(
                                                            'Created On: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              characters[index]
                                                                  .created
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        const Text(
                                                            'First Episode: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                                episode!.name,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)))
                                                      ]);
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        },
                        child: Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 130.0,
                                      width: 104.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  characters[index].image))),
                                    ),
                                    Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 2, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              characters[index].name,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 2),
                                              child: SizedBox(
                                                  width: 260,
                                                  child: Row(
                                                    children: [
                                                      characters[index]
                                                                  .status ==
                                                              'Alive'
                                                          ? Container(
                                                              width: 5.0,
                                                              height: 5.0,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            )
                                                          : characters[index]
                                                                      .status ==
                                                                  'Dead'
                                                              ? Container(
                                                                  width: 5.0,
                                                                  height: 5.0,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 5.0,
                                                                  height: 5.0,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        characters[index]
                                                            .status,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .blueGrey),
                                                      ),
                                                      Text(
                                                          ' - ' +
                                                              characters[index]
                                                                  .species,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .blueGrey))
                                                    ],
                                                  )),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 2),
                                              child: SizedBox(
                                                child: Text(
                                                  'Origin planet: ',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 2),
                                              child: SizedBox(
                                                child: Text(
                                                  characters[index].origin.name,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            )
                                          ],
                                        ),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 10.0,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: activeButton1
                            ? buttonColorActive
                            : buttonColorUnactive,
                      ),
                      onPressed: () {
                        if (page - 1 != 0) {
                          setState(() {
                            if (page - 1 == 1) {
                              activeButton1 = false;
                            } else {
                              activeButton1 = true;
                            }
                            if (page != 1) {
                              page--;
                              pageString = '?page=$page';
                            }
                          });
                        }
                      },
                      child: const Icon(Icons.arrow_back_rounded),
                    ),
                    Text(
                      'Page: $page',
                      style: const TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: activeButton2
                            ? buttonColorActive
                            : buttonColorUnactive,
                      ),
                      onPressed: () {
                        if (page + 1 != totalPages) {
                          setState(() {
                            if (page + 1 == totalPages) {
                              activeButton1 = false;
                            } else {
                              activeButton1 = true;
                            }
                            if (page != totalPages) {
                              page++;
                              pageString = '?page=$page';
                            }
                          });
                        }
                      },
                      child: const Icon(Icons.arrow_forward_rounded),
                    )
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
