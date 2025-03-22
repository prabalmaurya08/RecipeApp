import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/profile/presentation/bloc/profile_bloc.dart';

class ProfileHome extends StatelessWidget {
  final String userId;

  const ProfileHome({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoadedState) {
            final user = state.profile;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name}'),
                  Text('Email: ${user.email}'),
                  Text('ID: ${user.id}'),
                ],
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Initial state'));
          }
        },
      ),
    );
  }
}
