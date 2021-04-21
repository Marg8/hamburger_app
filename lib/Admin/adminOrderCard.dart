import 'package:app_hamburger/Admin/adminOrderDetails.dart';
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Widgets/orderCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


int counter=0;
class AdminOrderCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;
  final addressID;
  final String orderBy;

  AdminOrderCard({Key key, this.itemCount, this.data, this.orderID, this.addressID, this.orderBy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
        Route route;
        if(counter >= 0)
          {
            counter = counter + 1;
            route = MaterialPageRoute(builder: (c)=> AdminOrderDetails(orderID: orderID, orderBy: orderBy, addressID: addressID,));
          }
        Navigator.push(context, route);
      },
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
          new BoxShadow(
          color: Colors.black,
          offset: new Offset(0.0, 5.0),
          blurRadius: 5.0,
        ),
         ],
          borderRadius: BorderRadius.circular(15),
          gradient: new LinearGradient(
            colors: [Colors.black, Colors.black],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),          
        ),
        padding: EdgeInsets.all(1.0),
        margin: EdgeInsets.all(10.0),
        height: itemCount * 150.0,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c, index)
        {
          
          ItemModel model = ItemModel.fromJson(data[index].data());
          return sourceOrderInfo2(model, context);
          
        },
        ),
        
      ),
    );
    
    
  }
}
double width;

Widget sourceOrderInfo3(ItemModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return  Padding(
        padding: EdgeInsets.all(1.0),
        child: Container(
        height: 149.0,
        width: width,
        decoration: BoxDecoration(
        boxShadow: [
        new BoxShadow(
        color: Colors.black,
        offset: new Offset(0.0, 5.0),
        blurRadius: 5.0,
          ),
           ],
        borderRadius: BorderRadius.circular(15),
        gradient: new LinearGradient(
        colors: [Colors.white, Colors.white],
        ),
        ),
        child: Row(
          children: [
            Image.network(model.thumbnailUrl,
            width: 140.0,
            height: 140.0,
            ),

            SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            model.title ?? '',
                            style: TextStyle(
                                color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            model.shortInfo ?? '',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  r"Total Price: ",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                Text(
                                  r"$",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                Text(
                                  (model.price ?? '').toString(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  r"Cantidad: ",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                Text(
                                  (model.qtyitems ?? "").toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Flexible(
                    child: Container(),
                    ),
                  
          
                  
                ],
              ),
              
            )
            
          ],
          
        ),
        
      ),
  );


}