

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class TextLayer extends StatefulWidget {
  final VoidCallback delete;
  final int index;
  const TextLayer({Key key,this.index,this.delete}) : super(key: key);
  @override
  _TextLayerState createState() => _TextLayerState();
}

class _TextLayerState extends State<TextLayer> {
  bool _sizing=false;
  Color dialogPickerColor;
  double _textSize=30.0;
  @override
  void initState() {
    super.initState();
    dialogPickerColor = Colors.red;
  }

  Offset offset = Offset.zero;
bool _active=true;
Color textColor=Colors.blue;
  void _sizeModalBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            height:80,
            padding: EdgeInsets.only(bottom:12),
            child: StatefulBuilder(
              builder:(context,setState){
                return new Slider(
                value: _textSize,
                min:6,
                max:100,
                label: "Font Size",
                onChanged:(val){
                  setState((){});
                  onChange(val);

                },
                );
              }
            )
          );
        });
  }
 onChange(double value){
    setState(() {
      _textSize=value;
    });

 }
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
                  _sizing=false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border:_active?Border.all(color: Colors.pink):Border.all(color: Colors.transparent),

                ),
                padding:EdgeInsets.all(.5),
                child: Text(texts[widget.index],style: TextStyle(color:dialogPickerColor,fontSize:_textSize,
                    ),),
              ),
            ),

           _active?Container(
             //width: 300,

             child: Column(
               children: [
                 Row(

                   children: [
                     IconButton(onPressed: (){
                       _sizeModalBottomSheet(context);
                     }, icon: Icon(Icons.font_download),),
                     IconButton(onPressed: (){
                       setState(() {
                         _sizing=!_sizing;
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

                  final Color colorBeforeDialog = dialogPickerColor;
                  if (!(await colorDialogPicker())) {
                    setState(() {
                      dialogPickerColor = colorBeforeDialog;
                    });
                  }




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
  Future<bool>colorDialogPicker()async{

    return ColorPicker(
      color: dialogPickerColor,
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
    showMaterialName: true,
    showColorName: true,
    showColorCode: true,
    materialNameTextStyle: Theme.of(context).textTheme.caption,
    colorNameTextStyle: Theme.of(context).textTheme.caption,
    colorCodeTextStyle: Theme.of(context).textTheme.caption,
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    }, onColorChanged:(Color color) =>
        setState(() => dialogPickerColor = color),).showPickerDialog(
      context,
      constraints:
      const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );


  }

  fontSizeSlide(){
    return AlertDialog(
      content: Container(
        height:10,
        child: Slider(
          value: _textSize,
          min:6,
          max:100,
          label: "Font Size",
          onChanged:(double val){
            setState(() {
              _textSize=val;
            });
          },
        ),
      ),);
  }

}


