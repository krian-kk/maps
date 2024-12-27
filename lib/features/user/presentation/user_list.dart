import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/features/user/bloc/user_bloc.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(LoadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserBloc>().add(LoadUserEvent());
            },
            child: ListView.builder(
              itemCount: state.user.length,
              itemBuilder: (context, index) {
                final user = state.user[index];
                return Column(
                  children: [Text(user.name ?? '')],
                );
              },
            ),
          );
        } else if (state is UserError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
              ],
            ),
          );
        }
        return Container();
      },
    ));
  }
}
