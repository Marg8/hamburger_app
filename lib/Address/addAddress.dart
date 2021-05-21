import 'package:app_hamburger/Address/provideraddress.dart';
import 'package:app_hamburger/Config/config.dart';
import 'package:app_hamburger/Models/address.dart';
import 'package:app_hamburger/Widgets/customAppBar.dart';
import 'package:app_hamburger/Widgets/myDrawer.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final cName = TextEditingController();

  final cPhoneNumber = TextEditingController();

  final cFlatHomeNumber = TextEditingController();

  final cCity = TextEditingController();

  final cState = TextEditingController();

  final cPinCode = TextEditingController();

  @override
  void initState() {
    _getCodigoPostal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldMessengerKey,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formKey.currentState.validate()) {
              final model = AddressModel(
                name: cName.text.trim(),
                state: cState.text.trim(),
                pincode: cPinCode.text,
                phoneNumber: cPhoneNumber.text,
                flatNumber: cFlatHomeNumber.text,
                city: cCity.text.trim(),
                addressID: DateTime.now().millisecondsSinceEpoch.toString(),
              ).toJson();

              //add to firebase
              EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .doc(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .doc(DateTime.now().millisecondsSinceEpoch.toString())
                  .set(model)
                  .then((value) {
                final snack1 = ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Nueva Direccion Agregada Exitosamente.")));
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
        body: Column(
          children: [
            AddInput(
                formKey: formKey,
                cName: cName,
                cPhoneNumber: cPhoneNumber,
                cFlatHomeNumber: cFlatHomeNumber,
                cCity: cCity,
                cState: cState,
                cPinCode: cPinCode),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: _codigoPostal,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Select State'),
                          onChanged: (String newValue) {
                            setState(() {
                              _colonia = null;
                              _codigoPostal = newValue;
                              _getColoniaList();
                              print(_codigoPostal);
                            });
                          },
                          items: getOption?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(
                                      item["Código Postal"].toString()),
                                  value: item["Código Postal"].toString(),
                                );
                              })?.toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: _colonia,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Colonia'),
                          onChanged: (String newValue) {
                            setState(() {
                              _colonia = newValue;

                              print(_colonia);
                            });
                          },
                          items: coloniaList?.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(
                                      item["Nombre Asentamiento"].toString()),
                                  value: item["Nombre Asentamiento"].toString(),
                                );
                              })?.toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  String _codigoPostal;
  List getOption;
  Future<String> _getCodigoPostal() async {
    await rootBundle.loadString("json/address.json").then((response) {
      Map datos = json.decode(response);

      setState(() {
        getOption = datos["0"];
      });
    });
  }

  String _colonia;
  List coloniaList;
  Future<String> _getColoniaList() async {
    await rootBundle.loadString("json/addressdata.json").then((response) {
      Map datos = json.decode(response);

      setState(() {
        coloniaList = datos[_codigoPostal];
      });
    });
  }

  // Widget _lista() {
  //   return FutureBuilder(
  //     future: addressProvider.loadData(),
  //     initialData: [],
  //     builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
  //       return DropdownButton(
  //         value: _opcionSeleccionada,
  //         items: _listaItems(snapshot.data, context)
  //             .map((opt) => DropdownMenuItem<String>(
  //                   child: Text(_opcionSeleccionada),
  //                   value: _opcionSeleccionada,
  //                 ))
  //             .toList(),
  //         onChanged: (opt) {
  //           setState(() {
  //             _opcionSeleccionada = opt;
  //           });
  //         },
  //       );
  //     },
  //   );
  // }

  // List<DropdownMenuItem<String>> _listaItems(
  //     List<dynamic> data, BuildContext context) {
  //   final List<DropdownMenuItem<String>> getOption =
  //       new List.empty(growable: true);

  //   data.forEach((opt) {
  //     getOption.add(DropdownMenuItem(
  //       child: Text(opt["Nombre Asentamiento"]),
  //       value: "prueba",
  //     ));
  //   });

  //   return getOption;
  // }
}

class AddInput extends StatelessWidget {
  const AddInput({
    Key key,
    @required this.formKey,
    @required this.cName,
    @required this.cPhoneNumber,
    @required this.cFlatHomeNumber,
    @required this.cCity,
    @required this.cState,
    @required this.cPinCode,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController cName;
  final TextEditingController cPhoneNumber;
  final TextEditingController cFlatHomeNumber;
  final TextEditingController cCity;
  final TextEditingController cState;
  final TextEditingController cPinCode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Agregar Direccion Para Entrega",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
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
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  MyTextField({
    Key key,
    this.hint,
    this.controller,
  }) : super(key: key);

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

deleteAddress(BuildContext context, String addressID) {
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection(EcommerceApp.subCollectionAddress)
      .doc(addressID)
      .delete();

  Fluttertoast.showToast(msg: "Direccion Borrada");
}
