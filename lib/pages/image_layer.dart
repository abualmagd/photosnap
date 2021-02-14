import 'package:photo_snap/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:photo_snap/custom_path.dart';


class ImageLayer extends StatefulWidget {
  final VoidCallback delete;
  final int index;

  const ImageLayer({Key key, this.delete, this.index}) : super(key: key);

  @override
  _ImageLayerState createState() => _ImageLayerState();
}

class _ImageLayerState extends State<ImageLayer> {

  Offset offset=Offset.zero;
  bool _active=true;

 var _shape;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                padding:EdgeInsets.all(3),
                child: ClipPath(
                  clipper:_shape,
                  child: Container(
                    height: 140,
                    width: 140,
                    child: Image.file(layers[widget.index],fit: BoxFit.cover,),



                  ),
                ),
              ),
            ),

            _active?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //width: 300,

                child: Column(
                  children: [
                    Row(

                      children: [
                        IconButton(onPressed: (){

                        }, icon: Icon(Icons.font_download),),
                        IconButton(onPressed: (){
                          setState(() {
                            _shape= DiagonalPathClipperOne();
                          });

                        }, icon: Icon(Icons.border_color),),
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
                        IconButton(onPressed: ()async{

                        }, icon: Icon(Icons.color_lens_outlined),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.redo_outlined),),
                      ],
                    ),

                  ],
                )

                ,color: Colors.black45,),
            ):SizedBox.shrink(),


          ],
        ),
      ),



    );
  }
}
