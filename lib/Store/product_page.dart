import 'package:animate_do/animate_do.dart';
import 'package:app_hamburger/Models/item.dart';
import 'package:app_hamburger/Store/storehome.dart';
import 'package:app_hamburger/Widgets/customAppBar.dart';
import 'package:app_hamburger/Widgets/loadingWidget.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatefulWidget
{
  
  final ItemModel itemModel;
  final ItemColorModel modelcolor;
  ProductPage({this.itemModel, this.modelcolor});
  @override
  _ProductPageState createState() => _ProductPageState();
}

int qtyItems1 = 1;
List<dynamic> _colores = ["Negro", "Verde" , "Amarillo", "Azul","" ];
String opcionesColor = "";



class _ProductPageState extends State<ProductPage> {


  @override
  Widget build(BuildContext context)
  {
    
    Size screenSize = MediaQuery.of(context).size;
 
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: opcionesColor == "" ? buildListView(context) : buildListViewColor(context) ,

        ),
      );

  }

  ListView buildListView(BuildContext context) {
    return ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
          top: 4, bottom: 1, left: 8, right: 8
           ),
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                          child: Image.network(widget.itemModel.thumbnailUrl,),
                        width: 350,
                        height: 350,
                      ),
                    ),
                    Container(
                      
                      color: Colors.grey[300],
                      child: SizedBox(
                        height: 1.0,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                   top: 1, bottom: 0, left: 30, right: 0
                   ),
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          widget.itemModel.title,
                          style: boldTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          widget.itemModel.longDescription,

                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          r"$" + widget.itemModel.price.toString() + " MXN",
                          style: boldTextStyle,

                        ),
                        SizedBox(
                          height: 0.0,
                        ),
                        
                      ],
                    
                  ),
                ),
                
                OnClickforAddToCart(widget: widget),
                SizedBox(height: 10.0),
                MultipleOptions(),
                
                
              ],
            ),
          ),
        ],
      );
  }

  buildListViewColor(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
     stream: Firestore.instance
          .collection("items")
          .document("1612685920830")
          .collection("productcolor").snapshots(),
           builder: (context, dataSnapshot) {
          
                  return !dataSnapshot.hasData
                      ?  circularProgress()                      
                      : ListView.builder(                     
                          itemBuilder: (context, index) {
                          ItemColorModel modelcolor = ItemColorModel.fromJson(
                          dataSnapshot.data.documents[index].data);
                          
                          return sourceInfoColor(modelcolor, context);
                          
                          },
                          itemCount: dataSnapshot.data.documents.length,
                        );
                });
          

          }

  

  }

  sourceInfoColor(modelcolor, context){
    return 
          Container(
            padding: const EdgeInsets.only(
          top: 4, bottom: 1, left: 8, right: 8
           ),
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                          child: Image.network(modelcolor.thumbnailUrl,),
                        width: 350,
                        height: 350,
                      ),
                    ),
                    Container(
                      
                      color: Colors.grey[300],
                      child: SizedBox(
                        height: 1.0,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                   top: 1, bottom: 0, left: 30, right: 0
                   ),
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          modelcolor.title,
                          style: boldTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          modelcolor.longDescription,

                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          r"$" + modelcolor.price.toString() + " MXN",
                          style: boldTextStyle,

                        ),
                        SizedBox(
                          height: 0.0,
                        ),
                        
                      ],
                    
                  ),
                ),
                
                
                SizedBox(height: 10.0),
                MultipleOptions(),
                
                
              ],
            ),
          
        
      );
  }
    
 

class OnClickforAddToCart extends StatelessWidget {
  const OnClickforAddToCart({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ProductPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
      child: Center(
        child: InkWell(
          onTap: () => checkItemInCart(widget.itemModel.title, context),
          child: AddToCartBottom(),
        ),
      ),
    );
  }
}

class OnClickforAddToCartColor extends StatelessWidget {
  const OnClickforAddToCartColor({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ProductPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
      child: Center(
        child: InkWell(
          onTap: () => checkItemInCart(widget.itemModel.title, context),
          child: AddToCartBottom(),
        ),
      ),
    );
  }
}

class MultipleOptions extends StatefulWidget {
  const MultipleOptions({
    Key key,
  }) : super(key: key);

  @override
  _MultipleOptionsState createState() => _MultipleOptionsState();
}

class _MultipleOptionsState extends State<MultipleOptions> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20, bottom: 0, left: 36, right: 36
        ),
        child: Column(
          children: <Widget>[
            TouchPill(),
            SizedBox(height: 16),
            Container(
              child: Text("Opcion de Colores"),
            ),
            SizedBox(height: 30),
            //controls
            Row(
              children:<Widget> [
                Expanded(
                  child: Option(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
        ),
      ),
                 child: Row(
                 children:<Widget> [
                  Container(
                  width: 50.0,
       height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Container(
              child: IconButton(    
          icon:Icon(Icons.remove,
            color: Colors.grey,
          ),
          onPressed: ()  
                {
                  
                 
                  setState(() {
                  qtyItems1--;    
    
                     });
                  
                },
        ),
      ),
    ),
          Expanded(
            child: Text("$qtyItems1",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Container(
              child: IconButton(    
          icon:Icon(Icons.add,
            color: Colors.grey,
          ),
          onPressed: ()  
                {
                  
                  
                  
                  setState(() {
                  qtyItems1++;    
    
                     });
                },
        ),
      ),
    ),
        ],
      ),
    ),
                ),
              ],
            ),
            SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}

class AddToCartBottom extends StatelessWidget {
  const AddToCartBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width:150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          gradient: LinearGradient(
              colors: [Colors.black, Colors.black],
          ),
        ),
        child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,),
      ),
    );
  }
}
class TouchPill extends StatelessWidget {
  const TouchPill({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}


class Option extends StatefulWidget {
 

  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 10,
        ),
      ),
      child:Center(child: _colorDropdown())
    );
  }

List<DropdownMenuItem<dynamic>> getOpcionesDropdown(){

List<DropdownMenuItem<dynamic>> lista = new List.empty(growable: true);

_colores.forEach((color) {
  lista.add(DropdownMenuItem(
    child: Text(color),
    value: color,
  ));
 });
 return lista;
}



Widget _colorDropdown() {

  return DropdownButton(
    value: opcionesColor,
    items: getOpcionesDropdown(),
    onChanged: (opt){

      setState( (){
      opcionesColor = opt;  
      
      });


  

      
      
    },
    );
}
}



const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

