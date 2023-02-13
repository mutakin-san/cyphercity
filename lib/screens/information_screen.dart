import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.only(
                    top: 40, bottom: 45, left: 16, right: 16),
                decoration: BoxDecoration(
                    color: Color.gray,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          child: Image.asset("assets/images/cc_logo.png",
                              height: 60),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "About Us",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ultricies tristique nulla aliquet enim. Ipsum faucibus vitae aliquet nec. Pharetra massa massa ultricies mi quis hendrerit. Vel turpis nunc eget lorem dolor. Id venenatis a condimentum vitae sapien pellentesque habitant. Lacus sed viverra tellus in hac habitasse platea dictumst. At consectetur lorem donec massa sapien faucibus et. Mollis nunc sed id semper risus. Sit amet luctus venenatis lectus magna fringilla urna. Id leo in vitae turpis massa sed elementum. Sit amet justo donec enim diam vulputate ut pharetra sit. Quis auctor elit sed vulputate. Vehicula ipsum a arcu cursus vitae congue mauris. Est pellentesque elit ullamcorper dignissim cras.
                
                Pulvinar neque laoreet suspendisse interdum consectetur. Ut etiam sit amet nisl purus in. Pellentesque nec nam aliquam sem et. Odio ut sem nulla pharetra diam sit. Massa sapien faucibus et molestie ac. Et leo duis ut diam quam nulla porttitor massa id. Ac tortor vitae purus faucibus ornare suspendisse sed. Nisi porta lorem mollis aliquam ut porttitor leo. Pharetra magna ac placerat vestibulum. Purus sit amet volutpat consequat mauris nunc. Proin sagittis nisl rhoncus mattis rhoncus. Risus nec feugiat in fermentum posuere urna.
                
                Tincidunt ornare massa eget egestas purus viverra accumsan. Nunc non blandit massa enim nec dui nunc mattis enim. Mattis nunc sed blandit libero. Diam volutpat commodo sed egestas egestas fringilla. Faucibus vitae aliquet nec ullamcorper sit amet. Mauris commodo quis imperdiet massa tincidunt nunc pulvinar. Dolor magna eget est lorem ipsum dolor sit amet consectetur. Euismod nisi porta lorem mollis aliquam ut porttitor. Elit eget gravida cum sociis natoque penatibus et magnis. Consequat ac felis donec et odio pellentesque diam. Quis lectus nulla at volutpat diam. Vel quam elementum pulvinar etiam non quam lacus. Vel pharetra vel turpis nunc eget. Morbi non arcu risus quis. Nibh tortor id aliquet lectus proin nibh. Aliquam malesuada bibendum arcu vitae elementum curabitur.
                
                Ac tortor dignissim convallis aenean et tortor at. Etiam dignissim diam quis enim. Enim diam vulputate ut pharetra sit amet. Et netus et malesuada fames ac. Nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit. Amet volutpat consequat mauris nunc. Ultricies tristique nulla aliquet enim tortor at auctor urna nunc. Quisque sagittis purus sit amet volutpat consequat mauris. Feugiat vivamus at augue eget arcu dictum varius duis. Purus gravida quis blandit turpis cursus. Ut faucibus pulvinar elementum integer. Suscipit adipiscing bibendum est ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin. Tellus in metus vulputate eu.
                
                Et odio pellentesque diam volutpat commodo sed. In est ante in nibh mauris cursus mattis. Felis imperdiet proin fermentum leo vel. Posuere morbi leo urna molestie at elementum. Non enim praesent elementum facilisis leo vel fringilla est ullamcorper. Sed vulputate mi sit amet mauris commodo quis imperdiet massa. In nulla posuere sollicitudin aliquam ultrices sagittis orci a. Ut morbi tincidunt augue interdum velit euismod in. Pellentesque dignissim enim sit amet venenatis. Tristique senectus et netus et. Elementum curabitur vitae nunc sed velit. Ac ut consequat semper viverra nam libero justo. Enim nec dui nunc mattis.""",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
