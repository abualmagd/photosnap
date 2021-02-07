
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                IconButton(icon: Icon(Icons.text_fields), onPressed: (){}),
                IconButton(icon: Icon(Icons.emoji_emotions), onPressed: (){}),
                IconButton(icon: Icon(Icons.filter_frames), onPressed: (){}),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
