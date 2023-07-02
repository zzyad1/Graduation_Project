import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class mercy_button extends StatefulWidget {
   mercy_button( this.url , this.button_name,[this.timer=0,this.settime=false]);

   final String url;
   final String button_name;
   final int timer;
   bool settime;
  @override
  State<mercy_button> createState() => mercy_buttonState();
}

class mercy_buttonState extends State<mercy_button> {



  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.teal,),
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          FlutterRingtonePlayer.play(fromAsset: widget.url);
          if(widget.settime) {
            Future.delayed(Duration(seconds: widget.timer), () {
              FlutterRingtonePlayer.stop();
              setState(() {});
            });
          } },
        child: Text(
          widget.button_name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

