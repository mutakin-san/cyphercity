import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../core/repos/repositories.dart';
import '../widgets/background_gradient.dart';
import '../utilities/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          FutureBuilder(
              future: RepositoryProvider.of<UserRepository>(context)
                  .getDetailUser(userId: userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: Color.yellow));
                }

                if (snapshot.hasData && snapshot.data?.data != null) {
                  final userProfile = snapshot.data!.data!;

                  return ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top,
                            bottom: 48,
                            left: 16,
                            right: 16),
                        decoration: BoxDecoration(
                            color: Color.gray,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.account_circle_rounded,
                                  size: 55,
                                ),
                                Text(
                                  userProfile.namaLengkap,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.email),
                                        const SizedBox(width: 8),
                                        Text(userProfile.email),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.phone),
                                        const SizedBox(width: 8),
                                        Text(userProfile.noHp),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<UserBloc>().add(UserLogout());
                                  },
                                  iconSize: 30,
                                  icon: const Icon(Icons.logout),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Center(
                    child: Text(snapshot.data?.message ?? "",
                        style: TextStyle(color: Color.yellow)));
              }),
        ],
      ),
    );
  }
}
