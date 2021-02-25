
import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Models/address.dart';
import 'package:app_hamburger/Widgets/customAppBar.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';



class AddAddress extends StatelessWidget
{
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldMessengerKey,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()
          {
            if(formKey.currentState.validate())
              {
                final model = AddressModel(
                  name: cName.text.trim(),
                  state: cState.text.trim(),
                  pincode: cPinCode.text,
                  phoneNumber: cPhoneNumber.text,
                  flatNumber: cFlatHomeNumber.text,
                  city: cCity.text.trim(),
                ).toJson();

                //add to firebase
                EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                .collection(EcommerceApp.subCollectionAddress)
                .document(DateTime.now().millisecondsSinceEpoch.toString())
                .setData(model)
                .then((value) {
                  final snack1 = ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nueva Direccion Agregada Exitosamente.")));
                  print(snack1);
                  //No se necesita esta linea Cuando se implementa ScaffoldMessenger
                  //scaffoldMessengerKey.currentState.showSnackBar(snack1);
                  FocusScope.of(context).requestFocus(FocusNode());
                  formKey.currentState.reset();
                });


              }
          },
          label: Text("Listo"),
          backgroundColor: Colors.black,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Agregar Direccion Para Entrega",
                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      hint: "Nombre Completo",
                      controller: cName,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Numero de Celular",
                      controller: cPhoneNumber,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Direcion, Col, Calle, Numero de Casa",
                      controller: cFlatHomeNumber,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Ciudad",
                      controller: cCity,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Estado, Pais",
                      controller: cState,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Codigo Postal",
                      controller: cPinCode,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget
{
  final String hint;
  final TextEditingController controller;

  MyTextField({Key key, this.hint, this.controller,}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ? "No Puede Dejar Campos Vacios" : null,
      ),

    );
  }
}
