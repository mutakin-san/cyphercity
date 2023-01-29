import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:cyphercity/widgets/cc_material_button.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundGradient(),
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  bottom: 16,
                  left: 16,
                  right: 16),
              decoration: BoxDecoration(
                  color: Color.gray,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BrandLogo(width: 50, height: 50, isDark: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hi,\nSMPN : CIAMIS",
                          style: Theme.of(context).textTheme.titleMedium),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: const Icon(
                            Icons.account_circle_outlined,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Register for Competition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Color.red),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://s3.amazonaws.com/zenplannerwordpress-stack0/wp-content/uploads/sites/23/2019/10/25184742/Youth-Futsal-Banner-2019-2020-HS.jpg"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  color: Colors.black54,
                                  blurRadius: 10)
                            ]),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 100,
                        right: 100,
                        child: CCMaterialRedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register-competition');
                          },
                          text: "REG",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
