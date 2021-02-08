
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:photo_snap/pages/text_layer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _formKey = GlobalKey<FormState>();
 String _text;
 List _texts=[];
  File _image;
  final picker=ImagePicker();
Future getImage()async{
  final pikedFile=await picker.getImage(source:ImageSource.gallery);
  if(pikedFile!=null){
    setState(() {
      _image=File(pikedFile.path);
    });
  }else{
    print('something wrong');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 3,
        title: Text('PhotoSnap'),
      ),
      body: Column(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.pink,
            child:Center(child: Text('هنا اعلان ') ,),
          ),
          Expanded(
            child: Container(

              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Container(
                      height:MediaQuery.of(context).size.height*.60,
                      width: MediaQuery.of(context).size.width*.95,
                      child:_image!=null?Image.file(_image):Image.asset('assets/images/holders.jpeg',fit: BoxFit.cover,),
                    ),
                  ),
                  for(int i=0;i<_texts.length;i++)
                   TextLayer(text:_texts[i],color: Colors.blue,),



                ],
              ),
            ),
          ),
          Container(
            height:50,

            width: double.infinity,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.photo), onPressed:(){
                  getImage();
                }),
                IconButton(icon: Icon(Icons.filter), onPressed: (){}),
                IconButton(icon: Icon(Icons.text_fields), onPressed: (){
                  //show alert dialog
                  showAlert(context);

                }),
                IconButton(icon: Icon(Icons.emoji_emotions), onPressed: (){}),
                IconButton(icon: Icon(Icons.filter_frames), onPressed: (){}),
              ],
            ),
          ),
        ],
      ),

    );
  }
  showAlert(BuildContext context){
    return showDialog(context:context,
      barrierDismissible: false,
      builder:(_)=>

          AlertDialog(

            title: Text("Add your text "),
            content: Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                minLines: 1,
                validator: (value){
                  if(value.isEmpty){
                    return "write a text";
                  }
                  return null;
                },
                onSaved: (val){
                  setState(() {
                    _text=val;
                  });

                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ),
            ),
            actions: [
              FlatButton(onPressed: (){
               //
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  Navigator.pop(context);
                  _texts.add(_text);
                  print(_texts[0]);
                }

              }, child:Text('continue')),
              FlatButton(onPressed: (){

                Navigator.pop(context);
              }, child:Text('discard')),
            ],
          ),
    );

  }
}
