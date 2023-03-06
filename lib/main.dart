import 'package:api_bloc/logic/blocs_and_cubits/fetchApi_cubit/apiUser_cubit.dart';
import 'package:api_bloc/logic/blocs_and_cubits/internet_cubit/internet_cubit.dart';
import 'package:api_bloc/data/repository/user_repository.dart';
import 'package:api_bloc/presentation/router.dart';
import 'package:api_bloc/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //global access is given to internet cubit i.e all over app
    //to check connectivity status in the app
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: RepositoryProvider(
        create: (context) => UserRepository(),
        child: MaterialApp(
          title: 'Lanceme up proj2',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
