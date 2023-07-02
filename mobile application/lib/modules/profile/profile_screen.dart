import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'Edit_profile.dart';


class profile_screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppBloc, AppState>(
      builder: (context, state) {
        var userDataModel = AppBloc.get(context).userDataModel;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    //backgroundImage: AssetImage('assets/profile-pic.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${userDataModel?.username}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${userDataModel?.bio}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  //SizedBox(height: 16),
                  // Container(
                  //   // child: MaterialButton(
                  //   //   onPressed: () {
                  //   //     Navigator.push(context , MaterialPageRoute(builder: (context) => EditProfile()));
                  //   //   },
                  //   //   child: Text('Edit Profile',
                  //   //     style: TextStyle(
                  //   //         color: Colors.white) ,
                  //   //   ),
                  //   // ),
                  //   decoration: BoxDecoration(
                  //       color: Colors.teal
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Container(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('${userDataModel?.phone}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('${userDataModel?.email}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ),
        );
      },
      listener: (context, state) {},);
  }
}
