import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlyfilms/models/episode.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/season.dart';

final firestore = FirebaseFirestore.instance;

_followingId(int id) {
  return "$id-${FirebaseAuth.instance.currentUser.uid}";
}

class FollowObj {
  final Ep season;
  final List<Ep> episodes;

  FollowObj({this.season, this.episodes});
}

class Ep {
  final String id;
  DateTime seen;

  Ep({this.id, this.seen});
}

// _episodesId(int seasonNumber, int episodeNumber) {
//   return "$seasonNumber-$episodeNumber";
// }

get(int id) async {
  return await firestore.collection("following").doc(_followingId(id)).get();
}

getSeasonsAndEpisodes(int id) async {
  List<FollowObj> result = [];
  var seasons = await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .get();

  for (var s in seasons.docs) {
    var eps = await firestore
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("following")
        .doc("$id")
        .collection("seasons")
        .doc(s.id)
        .collection("episodes")
        .get();
    var ss = new Ep(id: s.id, seen: s.get("seen").toDate());
    var ee = eps.docs.length > 0
        ? eps.docs
            .map<Ep>((ep) => new Ep(id: ep.id, seen: ep.get("seen").toDate()))
            .toList()
        : new List<Ep>();
    result.add(new FollowObj(season: ss, episodes: ee));
    // {"season": , "episodes": e.docs.map((e) => e.data())});
  }
  return result;
}

getEpisodes(int id) async {
  return await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      // TODO
      .collection("episodes")
      .get();
}

follow(int id, MediaType type) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .set({"type": type.url});
}

see(int id) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .update({"seen": DateTime.now()});
}

unfollow(int id) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .delete();
}

unsee(int id) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .update({"seen": null});
}

unseeEpisode(int id, Episode episode) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .doc("${episode.seasonNumber}")
      .collection("episodes")
      .doc("${episode.episodeNumber}")
      .delete();
}

unseeSeason(int id, Season season) async {
  var batch = firestore.batch();
  batch.delete(firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .doc("${season.seasonNumber}"));
  for (var episode in season.episodes) {
    var doc = firestore
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("following")
        .doc("$id")
        .collection("seasons")
        .doc("${episode.seasonNumber}")
        .collection("episodes")
        .doc("${episode.episodeNumber}");
    batch.delete(doc);
  }

  batch.commit();
}

seeSeason(int id, Season season) async {
  var batch = firestore.batch();
  batch.set(
      firestore
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("following")
          .doc("$id"),
      {"type": MediaType.tv.url},
      SetOptions(merge: true));
  batch.set(
      firestore
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("following")
          .doc("$id")
          .collection("seasons")
          .doc("${season.seasonNumber}"),
      {"seen": DateTime.now()},
      SetOptions(merge: true));
  for (var episode in season.episodes) {
    var doc = firestore
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("following")
        .doc("$id")
        .collection("seasons")
        .doc("${episode.seasonNumber}")
        .collection("episodes")
        .doc("${episode.episodeNumber}");
    batch.set(doc, {"seen": DateTime.now()});
  }

  batch.commit();
}

seeEpisode(int id, Episode episode) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .doc("${episode.seasonNumber}")
      .set({"seen": DateTime.now()}, SetOptions(merge: true));
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .doc("${episode.seasonNumber}")
      .collection("episodes")
      .doc("${episode.episodeNumber}")
      .set({"seen": DateTime.now()});
}

seeEpisodeWithPrevious(int id, List<Season> seasons, Episode episode) async {
  var batch = firestore.batch();
  // previous seasons
  for (var i = 0; i < episode.seasonNumber - 1; i++) {
    for (var ep in seasons[i].episodes) {
      var epDoc = firestore
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("following")
          .doc("$id")
          .collection("seasons")
          .doc("${ep.seasonNumber}")
          .collection("episodes")
          .doc("${ep.episodeNumber}");
      batch.set(epDoc, {"seen": DateTime.now()});
    }
  }
  // current season
  for (var i = 1; i <= episode.episodeNumber; i++) {
    var epDoc = firestore
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("following")
        .doc("$id")
        .collection("seasons")
        .doc("${episode.seasonNumber}")
        .collection("episodes")
        .doc("$i");
    batch.set(epDoc, {"seen": DateTime.now()});
  }

  batch.commit();
}
