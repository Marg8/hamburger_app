import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';
import 'package:app_hamburger/Widgets/searchBox.dart';
import 'package:app_hamburger/src/burger_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class HamburgerList extends StatefulWidget {
  
//   final int row;
//   HamburgerList({this.row});

//   @override
//   _HamburgerListState createState() => _HamburgerListState();
// }

// class _HamburgerListState extends State<HamburgerList> {
//   @override
//   Widget build(BuildContext context) {
//     int items = 10;
//     Widget burgerImage = Container(
//       height: 160,
//       width: 190,
//       child: Image.asset("images/hamburger3.png"),
//     );

//     return SliverToBoxAdapter(
//        child: Container(
//          height: widget.row == 2 ? 330 : 240,
//          margin: EdgeInsets.only(top: 10),
//          child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//            itemCount: items,
//            itemBuilder: (context, index){

//              bool reverse = index.isEven;

//              return Stack(
//                children: [
//                  Container(
//                    margin: EdgeInsets.only(left: 20,right: index == items ? 20 : 0),
//                    height: 240,
//                    width: 200,
//                    child: GestureDetector(
//                      onTap: (){
//                        Navigator.of(context).pushNamed(BurgerPage.tag);
//                      },
//                      child: Card(
//                      child: Padding(
//                        padding: const EdgeInsets.only(top: 20),
//                        child: Column(
//                          children: [
//                            Text("Chiken Burger",style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold
//                            ),
//                           ),
//                           Spacer(),
//                           Row(
//                             children: [
//                               Spacer(),
//                               Text("\$100 mxn",style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold)),
//                               Spacer(),
//                               Container(
//                                 height: 50,
//                                 width: 50,
//                                 child: Card(
//                                   color: Colors.white,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                                   child: Icon(Icons.add)
//                                   ),
//                               )
//                             ],
//                           )
//                          ],
//                          )
//                        ),
//                        elevation: 3,
//                        margin: EdgeInsets.all(10),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.only(
//                            bottomLeft: Radius.circular(45),
//                            bottomRight: Radius.circular(15),
//                            topLeft: Radius.circular(45),
//                            topRight: Radius.circular(45)

//                          )
//                        ),
//                      ),
//                    ),
//                  ),
//                  Positioned(
//                    top: reverse ? 50 : 50,
//                    child: GestureDetector(
//                      onTap: (){
//                        Navigator.of(context).pushNamed(BurgerPage.tag);

//                      },
//                      child: reverse ? burgerImage : burgerImage,
//                    ),
//                  )
//                ],
//              );
//            }
//            ),
//        ),
//     );
//   }
// }



Widget sourceInfoBurger(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {

      

      int items = 10;
    

   

            //  bool reverse = index.isEven;

             return Stack(
               children: [
                 Container(
                   
                   margin: EdgeInsets.only(left: 20,right: 20 ),
                   height: 240,
                   width: 200,
                   child: GestureDetector(
                     onTap: (){
                       Navigator.of(context).pushNamed(BurgerPage.tag);
                     },
                     child: Card(
                     
                     child: Padding(
                       padding: const EdgeInsets.only(top: 20),
                       child: Column(
                         children: [
                           Center(
                             child: Text(model.title,style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold
                             ),
                          ),
                           ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              Text(r"$",style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold)),
                              Text(model.price.toString(),style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold)),
                              Spacer(),
                              Container(
                                height: 50,
                                width: 50,
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Icon(Icons.add)
                                  ),
                              )
                            ],
                          )
                         ],
                         )
                       ),
                       elevation: 3,
                       margin: EdgeInsets.all(10),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.only(
                           bottomLeft: Radius.circular(45),
                           bottomRight: Radius.circular(15),
                           topLeft: Radius.circular(45),
                           topRight: Radius.circular(45)

                         )
                       ),
                     ),
                   ),
                 ),
                 Positioned(
                   top:  50,
                   child: GestureDetector(
                     onTap: (){
                       Navigator.of(context).pushNamed(BurgerPage.tag);

                     },
                     child:  Container(
                     height: 160,
                     width: 190,

                  child: FadeInImage(
                  image: NetworkImage(model.thumbnailUrl),
                  placeholder: AssetImage("images/loading.png"),
                  fadeInDuration: Duration(milliseconds: 50),
                  width: 140.0,
                  height: 140.0,
                  ),
                     ),
                   ),
                 )
               ],
             );
           }
          
       
    


    

    