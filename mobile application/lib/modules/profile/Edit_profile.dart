import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/models/user_model.dart';

import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class EditProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      builder: (context, state) {
        var userDataModel = AppBloc.get(context).userDataModel;
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      userDataModel?.username = value;
                    },
                    controller: TextEditingController(text: '${userDataModel?.username}'),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      userDataModel?.email = value;
                    },
                    controller: TextEditingController(text: '${userDataModel?.email}'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                    ),
                    onChanged: (value) {
                      userDataModel?.phone = value;
                    },
                    controller: TextEditingController(text: '${userDataModel?.phone}'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Save changes to database

                      Navigator.pop(context);
                    },
                    child: Text('Save Changes'),
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
