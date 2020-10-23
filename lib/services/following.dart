import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlyfilms/models/episode.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/season.dart';

final firestore = FirebaseFirestore.instance;

_followingId(int id) {
  return "$id-${FirebaseAuth.instance.currentUser.uid}";
}

// _episodesId(int seasonNumber, int episodeNumber) {
//   return "$seasonNumber-$episodeNumber";
// }

get(int id) async {
  return await firestore.collection("following").doc(_followingId(id)).get();
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
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .doc("${season.seasonNumber}")
      .set({"seen": null});
  // var batch = firestore.batch();

  // for (var episode in season.episodes) {
  //   var doc = firestore
  //       .collection("user")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .collection("following")
  //       .doc("$id")
  //       .collection("seasons")
  //       .doc("${episode.seasonNumber}")
  //       .collection("episodes")
  //       .doc("${episode.episodeNumber}");
  //   batch.delete(doc);
  // }

  // batch.commit();
}

seeSeason(int id, Season season) async {
  await firestore
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("following")
      .doc("$id")
      .collection("seasons")
      .doc("${season.seasonNumber}")
      .set({"seen": DateTime.now()});
}

seeEpisode(int id, Episode episode) async {
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
