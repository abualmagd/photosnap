

import 'package:flutter/material.dart';
import 'home_page.dart';

class TextLayer extends StatefulWidget {
  final VoidCallback delete;
  final int index;
  const TextLayer({Key key,this.index,this.delete}) : super(key: key);


  @override
  _TextLayerState createState() => _TextLayerState();
}

class _TextLayerState extends State<TextLayer> {
  Offset offset = Offset.zero;
bool _active=true;
Color textColor=Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Column(
          children: [
            GestureDetector(
              onPanUpdate: (details){
                setState(() {
                  offset=Offset(offset.dx+details.delta.dx, offset.dy + details.delta.dy);
                });},
              onTap: (){
                setState(() {
                  _active=!_active;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border:_active?Border.all(color: Colors.pink):Border.all(color: Colors.transparent),


                ),
                padding:EdgeInsets.all(6),
                child: Text(texts[widget.index],style: TextStyle(color:textColor,fontSize: 30),),
              ),
            ),

           _active?Container(
             //width: 300,

             child: Column(
               children: [
                 Row(

                   children: [
                     IconButton(onPressed: (){}, icon: Icon(Icons.font_download),),
                     IconButton(onPressed: (){}, icon: Icon(Icons.border_color),),
                     IconButton(onPressed: (){}, icon: Icon(Icons.photo_camera_back),),
                   ],
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                 ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     IconButton(onPressed: (){

                      widget.delete();
                     }, icon: Icon(Icons.delete_forever),),
                     IconButton(onPressed: (){
                       setState(() {
                         textColor=Colors.green;
                       });
                     }, icon: Icon(Icons.color_lens_outlined),),
                     IconButton(onPressed: (){}, icon: Icon(Icons.redo_outlined),),
                   ],
                 ),

               ],
             )

             ,color: Colors.black45,):SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
