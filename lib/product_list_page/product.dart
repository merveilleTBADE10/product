// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterpanier/product_page/product.dart';

// class product_list extends StatefulWidget {
//   const product_list({super.key});

//   @override
//   State<product_list> createState() => _product_listState();
// }

// class _product_listState extends State<product_list> {
//   List<String> title = [
//     "product_1",
//     "product_2",
//     "product_3",
//     "product_4",
//     "product_5",
//     "product_6",
//     "product_7",
//     "product_8",
//     "product_9",
//     "product_10",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0XFF674AEF),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => product()));
//           },
//           child: Icon(
//             Icons.arrow_back_rounded,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           "Panier",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => product_list()));
//                   },
//                   child: Icon(
//                     Icons.info,
//                     color: Colors.white,
//                   ))),
                  
//         ],
//       ),
//       body: title.length > 0
//           ? ListView.builder(
//               itemCount: title.length,
//               itemBuilder: ((context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Color(0xFFF2F2F2),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: ListTile(
//                         // l'icon chat
//                         leading: Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               image: DecorationImage(
//                                   image: AssetImage('img/plat5.jpg'),
//                                   fit: BoxFit.cover)),
//                         ),
//                         // titre du message
//                         title: Text(
//                           title[index],
//                           style: TextStyle(color: Colors.black, fontSize: 15),
//                         ),

//                         // l'icon check si la personne voit le mpessage
//                         trailing:
//                             Row(mainAxisSize: MainAxisSize.min, children: [
//                           Icon(
//                             Icons.visibility,
//                             color: Colors.green,
//                           ),
//                           Icon(
//                             Icons.edit,
//                             color: Colors.amber,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Stack(
//                                   clipBehavior: Clip.none,
//                                   children: [
//                                     Container(
//                                         padding: EdgeInsets.all(16),
//                                         height: 55,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20))),
//                                         child: Row(
//                                           children: [
                                           
//                                             Expanded(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "Product delete successfully",
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: Colors.white),
//                                                     maxLines: 2,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                     Positioned(
//                                         top: -5,
//                                         right: 0,
//                                         child: Stack(
//                                           children: [
//                                             Container(
//                                               width: 30,
//                                               height: 30,
//                                               decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white)),
//                                               child: Icon(
//                                                 Icons.close,
//                                                 color: Colors.white,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                   ],
//                                 ),
//                                 behavior: SnackBarBehavior.floating,
//                                 backgroundColor: Colors.red,
//                                 elevation: 0.0,
//                               ));
//                               setState(() {
//                                 title.removeAt(index);
//                               });
//                             },
//                             child: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ]),
//                       ),
//                     ),
//                   ),
//                 );
//               }))
//           : Center(child: Text("No Product in your list")),
//     );
//   }
// }
