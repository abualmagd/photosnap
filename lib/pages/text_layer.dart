import 'package:flutter/material.dart';

class TextLayer extends StatefulWidget {
  final String text;
  final Color color;
  const TextLayer({Key key, this.text,this.color}) : super(key: key);

  @override
  _TextLayerState createState() => _TextLayerState();
}

class _TextLayerState extends State<TextLayer> {
  Offset offset = Offset.zero;
bool _active=true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
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
            child: Text(widget.text,style: TextStyle(color:widget.color,fontSize: 30),),
          ),
        ),
      ),
    );
  }
}
