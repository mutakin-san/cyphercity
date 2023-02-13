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

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 32, left: 16, right: 16),
                        decoration: BoxDecoration(
                            color: Color.gray,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                        child: Stack(
                          children: [
                            Column(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: userProfile.statusSekolah == "0"
                                            ? Color.red
                                            : Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        userProfile.statusSekolah == "0"
                                            ? "Pribadi"
                                            : userProfile.statusSekolah == "1"
                                                ? "Official Sekolah"
                                                : "Official Umum",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        context
                                            .read<UserBloc>()
                                            .add(UserLogout());
                                      },
                                      iconSize: 30,
                                      icon: const Icon(Icons.logout),
                                    )
                                  ],
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                iconSize: 35,
                                icon: const Icon(Icons.arrow_back))
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
