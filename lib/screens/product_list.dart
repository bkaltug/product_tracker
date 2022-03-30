import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite_demo3/data/dbHelper.dart';
import 'package:sqflite_demo3/models/products.dart';
import 'package:sqflite_demo3/screens/product_add.dart';
import 'package:sqflite_demo3/screens/product_detail.dart';
import 'dart:math';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  List<Products> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Tracker"),
        centerTitle: true,
      ),
      body: buildProductsList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        tooltip: "Add new product",
        onPressed: () {
          goToProductAdd();
        },
      ),
    );
  }

  ListView buildProductsList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("lib/assets/flutter_logo.png"),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {
                goToDetail(this.products[position]);
              },
            ),
          );
        });
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductAdd(productCount)));
    if (result != null) {
      getProducts();
    }
  }

  void goToDetail(Products product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) {
      getProducts();
    }
  }
}
