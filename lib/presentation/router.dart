import 'package:api_bloc/data/repository/user_repository.dart';
import 'package:api_bloc/logic/blocs_and_cubits/internet_cubit/internet_cubit.dart';
import 'package:api_bloc/logic/blocs_and_cubits/postApi/post_api_bloc.dart';
import 'package:api_bloc/presentation/screens/postUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/blocs_and_cubits/fetchApi_cubit/apiUser_cubit.dart';
import 'screens/home.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => UserCubit(
                RepositoryProvider.of<UserRepository>(context),
                BlocProvider.of<InternetCubit>(context)),
            child: const HomePage(),
          ),
        );

      case '/post-api':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => PostApiBloc(
                RepositoryProvider.of<UserRepository>(context),
                BlocProvider.of<InternetCubit>(context)),
            child: const PostUserScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
