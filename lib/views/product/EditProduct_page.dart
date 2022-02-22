import 'dart:convert';

import 'package:crud_app/helper/endpoint.dart';
import 'package:crud_app/helper/http_helper.dart';
import 'package:crud_app/views/model/CategoryModel.dart';
import 'package:crud_app/views/product/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel model;
  const EditProductPage({Key? key, required this.model}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  HttpHelper _helper = new HttpHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String dropdownValue = '';
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _price = TextEditingController();
  final _category = TextEditingController();
  var _active = false;
  List<CategoryModel> categories = [];

 Widget textField({String? labelText, TextEditingController? controller}){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: labelText,
      ),
    );
  }

  findAllCategory() async{
    final res = await _helper.getData(baseUrl+find_categories);
    if(res.statusCode == 200){
      List<dynamic> data = json.decode(res.body);
      this.categories = data.map((e) => CategoryModel.fromMap(e)).toList();
      if(this.categories.isNotEmpty){
        setState(() {
          this.categories;
          this.dropdownValue = widget.model.category;
        });
      }
    }
  }


  @override
  void initState() {
    this._name.text = widget.model.name;
    this._quantity.text = widget.model.qty.toString();
    this._price.text = widget.model.price.toString();
    this.dropdownValue = widget.model.category;
    this.findAllCategory();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.showSnackBar(new SnackBar(content: new Text(value)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(title: Text("Edit Prouct"),),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Flexible(
              child: textField(labelText: "Name", controller: _name),
            ),
            Flexible(
              child: textField(labelText: "Quantity", controller: _quantity),
            ),
            Flexible(
              child: textField(labelText: "Price", controller: _price),
            ),
            Flexible(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: this.categories
                    .map<DropdownMenuItem<String>>((CategoryModel model) {
                  return DropdownMenuItem<String>(
                    value: model.categoryName,
                    child: Text(model.categoryName),
                  );
                }).toList(),
              )
            ),
            Row(
              children:[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: _active,
                    onChanged: (bool? value) {
                      setState(() {
                        _active = value!;
                      });
                    },
                  ),
                ),
                Text("Is Active")
              ]
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {

                    ProductModel model = ProductModel(name: _name.value.text, qty: int.parse(_quantity.value.text), price: double.parse(_price.value.text), isActive: _active, category: dropdownValue);
                  final res =  await _helper.postData('http://172.17.126.241:8080/product/v1/api/update/'+widget.model.id.toString(), model.toJson());
                  if(res.statusCode ==200){
                    Map<dynamic, dynamic> data = json.decode(res.body);
                    showInSnackBar(data["message"]);
                  }else{
                    print(res);
                  }
                  },
                  child: Text('Update'),
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
