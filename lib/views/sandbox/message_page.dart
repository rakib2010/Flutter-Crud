import 'dart:developer';

import 'package:crud_app/helper/http_helper.dart';
import 'package:crud_app/views/model/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _formKey = GlobalKey<FormState>();
  final _http = HttpHelper();
  final _subject = TextEditingController();
  final _content = TextEditingController();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  save() async{
    String sub = _subject.value.text ?? '';
    String cont = _content.value.text ?? '';
    var model = MessageModel(subject: sub, content: cont);
    String _body = model.toJson();
    try{
      final response = await _http.postData('http://192.168.206.241:9002/api/v1/topics/save', _body);

    }catch(e){
      log(e.toString());
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sand Box'),),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _subject,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _content,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Content',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  this.save();
                },
                child: Text('Send'),
              ),
            )
          ],
        ),
      )
    );
  }
}
