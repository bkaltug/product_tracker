import 'package:flutter/material.dart';
import 'package:sqflite_demo3/data/dbHelper.dart';
import 'package:sqflite_demo3/models/products.dart';

class ProductAdd extends StatefulWidget {
  int productCount;
  ProductAdd(int productCount) {
    this.productCount = productCount;
  }
  @override
  State<StatefulWidget> createState() {
    return _ProductAddState(productCount);
  }
}

class _ProductAddState extends State {
  int productCount;
  _ProductAddState(int productCount) {
    this.productCount = productCount;
  }
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();
  DbHelper dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  buildNameField(),
                  buildDescriptionField(),
                  buildUnitPriceField(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: buildSaveButton(),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Name"),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Description"),
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Unit price"),
      controller: txtUnitPrice,
    );
  }

  Widget buildSaveButton() {
    return ElevatedButton(
        onPressed: () {
          addProduct();
        },
        child: Text("Save"),
        style: ElevatedButton.styleFrom(primary: Colors.purple));
  }

  void addProduct() async {
    await dbHelper.insert(Products(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, true);
  }
}
