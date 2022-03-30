class Products {
  int id;
  String name;
  String description;
  double unitPrice;

  Products({this.name, this.description, this.unitPrice});
  Products.withId({this.id, this.name, this.description, this.unitPrice});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Products.fromObject(dynamic o) {
    this.id = o["id"];
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString());
  }
}
