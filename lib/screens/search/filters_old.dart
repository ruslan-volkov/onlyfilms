// import 'package:flutter/material.dart';
// import 'package:onlyfilms/models/genre.dart';
// import 'package:onlyfilms/services/fetch.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class Filters extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return FiltersState();
//   }
// }

// class FiltersState extends State<Filters> {
//   final types = ["Movie", "Tv Series", "Person"];
//   Future<List<Genre>> genres;

//   @override
//   void initState() {
//     super.initState();
//     // genres = getGenres();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return Container(
//             height: constraints.maxHeight / 2,
//             color: Color(0xFF585C89),
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       child: Center(
//                         child: Theme(
//                           data: ThemeData.dark(),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               ListView(
//                                 primary: true,
//                                 shrinkWrap: true,
//                                 children: <Widget>[
//                                   Wrap(
//                                     runAlignment: WrapAlignment.center,
//                                     alignment: WrapAlignment.center,
//                                     spacing: 20.0,
//                                     runSpacing: 0.0,
//                                     children: List<Widget>.generate(
//                                         types
//                                             .length, // place the length of the array here
//                                         (int index) {
//                                       return FilterChip(
//                                         selected: true,
//                                         onSelected: (test) => {
//                                           //     setState(() {
//                                           //   _selected = !_selected;
//                                           // });
//                                         },
//                                         label: Text(types[index]),
//                                         labelStyle:
//                                             TextStyle(color: Colors.white),
//                                         backgroundColor: Color(0xFF2A6A71),
//                                         selectedColor: Color(0xFF1B998B),
//                                         elevation: 10,
//                                         pressElevation: 5,
//                                       );
//                                       // return Chip(label: Text(types[index]));
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     color: Color(0xFF1B998B),
//                     height: 10,
//                     indent: 20,
//                     endIndent: 20,
//                   ),
//                   Expanded(
//                       flex: 4,
//                       child: Theme(
//                           data: ThemeData.dark(),
//                           // child: Column(
//                           //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           //   crossAxisAlignment: CrossAxisAlignment.center,
//                           //   children: [
//                           //     Expanded(
//                           //         child: Container(
//                           child: FutureBuilder(
//                             future: genres,
//                             builder: (context, snapshot) {
//                               switch (snapshot.connectionState) {
//                                 case ConnectionState.none:
//                                 case ConnectionState.waiting:
//                                 case ConnectionState.active:
//                                   return Container(
//                                     alignment: Alignment.center,
//                                     child: Text("Loading"),
//                                   );
//                                   break;
//                                 case ConnectionState.done:
//                                   if (snapshot.hasError) {
//                                     // return whatever you'd do for this case, probably an error
//                                     return Container(
//                                       alignment: Alignment.center,
//                                       child: Text("Error: ${snapshot.error}"),
//                                     );
//                                   }
//                                   var data = snapshot.data;
//                                   return StaggeredGridView.countBuilder(
//                                     scrollDirection: Axis.horizontal,
//                                     staggeredTileBuilder: (int index) =>
//                                         new StaggeredTile.fit(3),
//                                     crossAxisCount: 9,
//                                     padding: EdgeInsets.zero,
//                                     itemCount: data.length,
//                                     itemBuilder: (_, int index) => FilterChip(
//                                       selected: true,
//                                       onSelected: (test) => {
//                                         //     setState(() {
//                                         //   _selected = !_selected;
//                                         // });
//                                       },
//                                       label: Text(data[index].name),
//                                       labelStyle:
//                                           TextStyle(color: Colors.white),
//                                       backgroundColor: Color(0xFF2A6A71),
//                                       selectedColor: Color(0xFF1B998B),
//                                       elevation: 10,
//                                       pressElevation: 5,
//                                     ),
//                                     // itemBuilder:
//                                     //     (BuildContext context, int index) =>
//                                     //         Card(
//                                     //   child: Column(
//                                     //     children: <Widget>[
//                                     //       Image.network(images[index]),
//                                     //       Text("Some text"),
//                                     //     ],
//                                     //   ),
//                                     // ),
//                                     // staggeredTileBuilder: (int index) =>
//                                     //     new StaggeredTile.fit(2),
//                                     mainAxisSpacing: 4.0,
//                                     // crossAxisSpacing: 4.0,
//                                   );
//                                   // return GridView.builder(
//                                   //   scrollDirection: Axis.horizontal,
//                                   //   shrinkWrap: true,
//                                   //   gridDelegate:
//                                   //       SliverGridDelegateWithFixedCrossAxisCount(
//                                   //     childAspectRatio: 1,
//                                   //     crossAxisCount: 3,
//                                   //   ),
//                                   //   padding: EdgeInsets.zero,
//                                   //   reverse: false,
//                                   //   itemBuilder: (_, int index) => FilterChip(
//                                   //     selected: true,
//                                   //     onSelected: (test) => {
//                                   //       //     setState(() {
//                                   //       //   _selected = !_selected;
//                                   //       // });
//                                   //     },
//                                   //     label: Text(data[index].name),
//                                   //     labelStyle:
//                                   //         TextStyle(color: Colors.white),
//                                   //     backgroundColor: Color(0xFF2A6A71),
//                                   //     selectedColor: Color(0xFF1B998B),
//                                   //     elevation: 10,
//                                   //     pressElevation: 5,
//                                   //   ),
//                                   //   // Chip(label: Text(data[index].name)),
//                                   //   itemCount: data.length,
//                                   // );
//                                   break;
//                               }
//                             },
//                           )))
//                 ],
//               ),
//             ));
//         // Divider(
//         //   color: Color(0xFF1B998B),
//         //   height: 10,
//         //   indent: 20,
//         //   endIndent: 20,
//         // ),
//         // Expanded(
//         //   flex: 1,
//         //   child: Container(
//         //     child: Center(
//         //       child: Text("Release"),
//         //     ),
//         //   ),
//         // ),
//         // Padding(padding: EdgeInsets.only(bottom: 5))
//       },
//     );
//   }
// }
