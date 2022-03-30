import 'package:flutter/material.dart';
import 'package:sqflite_demo3/data/dbHelper.dart';
import 'package:sqflite_demo3/models/products.dart';

class ProductDetail extends StatefulWidget {
  Products product = Products();
  ProductDetail(Products product) {
    this.product = product;
  }
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { update, delete }

class _ProductDetailState extends State {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();
  DbHelper dbHelper = DbHelper();
  Products product = Products();
  _ProductDetailState(Products product) {
    this.product = product;
  }

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                    PopupMenuItem<Options>(
                        child: Text("Update"), value: Options.update),
                    PopupMenuItem<Options>(
                        child: Text("Delete"), value: Options.delete)
                  ])
        ],
      ),
      body: buildBodyField(),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Products.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.toString())));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildBodyField() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
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
      decoration: InputDecoration(labelText: "Unit Price"),
      controller: txtUnitPrice,
    );
  }
}
