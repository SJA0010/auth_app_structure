import 'package:auth_app_structure/scr/app_theme/color_scheme.dart';
import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:auth_app_structure/scr/common/widgets/custom_text_button.dart';
import 'package:auth_app_structure/scr/features/home/controllers/greeting_provider.dart';
import 'package:auth_app_structure/scr/features/home/pages/all_users.dart';
import 'package:auth_app_structure/scr/models/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme(context) => Theme.of(context).colorScheme;
    final greeting = Provider.of<GreetingProvider>(context).greeting;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Home",
              style: appTextTheme.headlineMedium,
            ),
            actions: [
              CustomTextButton(
                  onPressed: () {
                    Staticdata.signOut(context);
                  },
                  text: "Logout"),
              const SizedBox(width: 10)
            ],
            bottom: TabBar(tabs: [
              Text(
                "profile",
              ),
              Text(
                "Add friends",
              )
            ]),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          width: 1, color: appDarkColorScheme.primary)),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        "  ${greeting}  \nDear ${Staticdata.model?.userName}",
                        style: appTextTheme.displaySmall,
                      ),
                      CircleAvatar(radius: 50),
                      SizedBox(
                        width: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                            ),
                            SizedBox(
                                width: 270,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: Staticdata.model?.userName),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone",
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                            ),
                            SizedBox(width: 270, child: TextFormField())
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Eamil",
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                            ),
                            SizedBox(width: 270, child: TextFormField())
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "password",
                              style: appTextTheme.titleSmall?.copyWith(
                                  color: colorScheme(context).primary),
                            ),
                            SizedBox(width: 250, child: TextFormField())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AllUsers()
            ],
          ),
        ));
  }
}
