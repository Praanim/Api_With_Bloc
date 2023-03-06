import 'package:api_bloc/data/models/user_models.dart';
import 'package:api_bloc/logic/blocs_and_cubits/fetchApi_cubit/api_User_cubit_state.dart';
import 'package:api_bloc/presentation/widgets/alert_box.dart';

import 'package:api_bloc/presentation/widgets/mySnackBar.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs_and_cubits/fetchApi_cubit/apiUser_cubit.dart';
import '../widgets/customTextField.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _nameController;
  late TextEditingController _jobController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _jobController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUserFromApi();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Api With Bloc  (Tap to update tile)"),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is Connection_State) {
            _customSnackBar(context, state);
          }
          if (state is UserUpdatedState) {
            mySnackBar(
                context: context,
                content: state.message,
                backgroundColor: Colors.green);
          }
          if (state is UserDeletedState) {
            showAlertDialog(
                context: context,
                title: state.message['title']!,
                body: state.message['body']!);
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: Text("Loading Data >>In process"),
            );
          } else if (state is UserLoadedState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        _nameController.text = user.first_Name;
                        //update the userModel
                        _showCustomBottomSheet(context, user);
                      },
                      trailing: IconButton(
                          onPressed: () {
                            // call delete api function
                            BlocProvider.of<UserCubit>(context)
                                .deleteApiCall(userModel: user);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      title: Text("${user.first_Name}  ${user.last_Name}"),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar)),
                    ),
                  ),
                );
              },
              itemCount: state.users.length,
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text("Shiva is EveryWhere"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigate to postUserScreen
          Navigator.of(context).pushNamed('/post-api');
        },
        child: const Icon(Icons.add_task),
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context, UserModel user) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Update UserModel',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  label: "Name",
                  controller: _nameController,
                ),
                CustomTextField(
                  label: "Job",
                  controller: _jobController,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _jobController.text.isEmpty) {
                      //nothing will happen
                      Navigator.of(context).pop();
                      mySnackBar(
                          context: context,
                          content: "Some Field is missing",
                          backgroundColor: Colors.red);
                    } else {
                      BlocProvider.of<UserCubit>(context)
                          .putApiCall(user: user, job: _jobController.text);
                      _jobController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
  }

  void _customSnackBar(BuildContext context, Connection_State state) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${state.connectionType}")));
  }
}
