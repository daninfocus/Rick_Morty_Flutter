import 'package:flutter/material.dart';
import 'package:rick_morty/src/models/all_episodes.dart';

import '../globals.dart';

class EpisodeListView extends StatelessWidget {
  const EpisodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<AllEpisodes>(
        future: episodeClass.getAllEpisodes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Image(image: AssetImage('assets/loading.gif'));
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error Loading Data.'));
          } else {
            var episodes = snapshot.data!.results;
            return ListView.builder(
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(episodes[index].episode,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Column(
                    children: [
                      Text(
                        episodes[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        episodes[index].airDate,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      // for (var item in episodes[index].characters)
                      //   Text(
                      //     item,
                      //     style: TextStyle(color: Colors.white),
                      //   )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
