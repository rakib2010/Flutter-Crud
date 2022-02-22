import 'dart:convert';
import 'dart:math';

import 'package:crud_app/helper/endpoint.dart';
import 'package:crud_app/helper/http_helper.dart';
import 'package:crud_app/views/product/product_model.dart';
import 'package:crud_app/views/product/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EditProduct_page.dart';

class ShowProductPage extends StatefulWidget {
  const ShowProductPage({Key? key}) : super(key: key);

  @override
  _ShowProductPageState createState() => _ShowProductPageState();
}

class _ShowProductPageState extends State<ShowProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var products = [];
  final _http = new HttpHelper();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.showSnackBar(new SnackBar(content: new Text(value)));
  }
  
  getProducts() async {
    final res = await _http.getData("http://172.17.126.241:8080/product/v1/api/all");
    if(res.statusCode == 200){
      Map<dynamic, dynamic> data = json.decode(res.body);
      showInSnackBar(data["message"]);
      List<dynamic> dataList= data['data'];
      this.products = dataList.map((e) => ProductModel.fromMap(e)).toList();
      setState(() {
        this.products;
      });
    }
  }


  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Show Product"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductPage()));
                },
                child: Text('Add a new product'),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: this.products.length,
                  itemBuilder: (context, i){
                    ProductModel model = this.products[i];
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.album, size: 45),
                            title: Text(model.name)
                          ),
                          ListTile(
                              leading: Icon(Icons.album, size: 45),
                              title: Text(model.qty.toString())
                          ),
                          ListTile(
                              leading: Icon(Icons.album, size: 45),
                              title: Text(model.price.toString())
                          ),
                          ListTile(
                              leading: Icon(Icons.album, size: 45),
                              title: Text(model.category.toString())
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    var id = model.id;
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditProductPage(model: model)));
                                  },
                                  child: Text('Edit'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var id = model.id;
                                    final res = await _http.getData(baseUrl+delete_product+id.toString());
                                    if(res.statusCode  == 200){
                                      showInSnackBar("Product deleted successfully");
                                      this.products.removeAt(i);
                                      setState(() {
                                        this.products;
                                      });
                                    }
                                  },
                                  child: Text('Delete'),
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                    );
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
