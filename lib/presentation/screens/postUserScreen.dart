import 'package:api_bloc/constants/enum.dart';

import 'package:api_bloc/logic/blocs_and_cubits/postApi/post_api_bloc.dart';
import 'package:api_bloc/presentation/widgets/alert_box.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostUserScreen extends StatefulWidget {
  const PostUserScreen({super.key});

  @override
  State<PostUserScreen> createState() => _PostUserScreenState();
}

class _PostUserScreenState extends State<PostUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _jobController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a User"),
      ),
      body: BlocBuilder<PostApiBloc, PostApiState>(builder: (context, state) {
        if (state is CheckConnectionState &&
            state.connectionType == ConnectionType.noConnec) {
          return const Center(
            child: Text("There is no Internet Connection"),
          );
        } else {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<PostApiBloc, PostApiState>(
                  builder: (context, state) {
                    if (state is PostApiError) {
                      return Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    if (state is PostApiValidState) {
                      return const Text(
                        "Valid to submit",
                        style: TextStyle(color: Colors.green),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                TextField(
                  controller: _nameController,
                  onChanged: (value) {
                    BlocProvider.of<PostApiBloc>(context).add(
                        TextFieldChangedEvent(
                            nameValue: _nameController.text,
                            jobValue: _jobController.text));
                  },
                  decoration: const InputDecoration(hintText: "Enter the Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _jobController,
                  onChanged: (value) {
                    BlocProvider.of<PostApiBloc>(context).add(
                        TextFieldChangedEvent(
                            nameValue: _nameController.text.trim(),
                            jobValue: _jobController.text.trim()));
                  },
                  decoration: const InputDecoration(hintText: "Enter the Job"),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<PostApiBloc, PostApiState>(
                  listener: (context, state) {
                    //alert box dekhauney after post reqeust
                    if (state is PostApiResponseState) {
                      showAlertDialog(
                          context: context,
                          title: "Post request done",
                          body:
                              "Post request Time: ${state.postUserModel.dateTime}");
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        //go for post request only if there is validState
                        if (state is PostApiValidState) {
                          BlocProvider.of<PostApiBloc>(context).add(
                              TextFieldSubmittedEvent(
                                  name: _nameController.text.trim(),
                                  job: _jobController.text.trim()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: state is PostApiValidState
                              ? Colors.blue
                              : Colors.grey),
                      child: state is LoadingState
                          ? const CircularProgressIndicator()
                          : const Text("Submit"),
                    );
                  },
                )
              ],
            ),
          ));
        }
      }),
    );
  }
}
