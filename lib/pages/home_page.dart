
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:photo_snap/pages/image_layer.dart';
import 'package:photo_snap/pages/text_layer.dart';
List layers=[];
List texts=[];
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  remove(int index){
    setState(() {
      texts.removeAt(index);
    });

  }

  removeImage(int index){
    setState(() {
      layers.removeAt(index);
    });

  }










  var _formKey = GlobalKey<FormState>();
 String _text;

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

Future getLayer()async{

  final pikedFile=await picker.getImage(source:ImageSource.gallery);
  if(pikedFile!=null){
    setState(() {
      layers.add(File(pikedFile.path));
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
                      height:MediaQuery.of(context).size.height*.70,
                      width: MediaQuery.of(context).size.width*.95,
                      child:_image!=null?Image.file(_image):Image.asset('assets/images/holders.jpeg',fit: BoxFit.fill,),
                    ),
                  ),
                  for(int i=0;i<texts.length;i++)
                   TextLayer(index: i,delete:()=>remove(i),),

                  for(int i=0;i<layers.length;i++)
                    ImageLayer(index:i,delete:()=> remove(i),),


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
                IconButton(icon:_image==null?Icon(Icons.photo):Icon(Icons.add), onPressed:(){
                  if(_image==null) {
                    getImage();
                  }
                  getLayer();
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
                  texts.add(_text);
                  print(texts[0]);
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
