import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'Custome_emergenncy.dart';

class Emergency extends StatefulWidget {


  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppBloc, AppState>(
      builder: (context, state) {
        var userDataModel = AppBloc.get(context).userDataModel;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  mercy_button("assets/sound/emergency-alarm.mp3","Emergency alarm",15,true),
                  SizedBox(height: 25,),
                  mercy_button("assets/sound/hungry-ar.mp3","Im hungry"),
                  SizedBox(height: 25,),
                  mercy_button("assets/sound/pain-ar.mp3","pain"),
                  SizedBox(height: 25,),
                  mercy_button("assets/sound/thirsty-ar.mp3","Im thirsty"),
                  SizedBox(height: 25,),
                  mercy_button("assets/sound/bathroom-ar.mp3","I need to go to bathroom"),
                  SizedBox(height: 25,),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed:
                            ()=> launch("tel://${userDataModel?.phone}")
                        , child: Text("Call the Doctor")),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},);
  }
}