import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kedis/core/router/app_router.gr.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeRoutes(), 
        TimeRoute(),
        MenuRoute(),
        EvalutionRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[500],
              selectedFontSize: 0,
              unselectedFontSize: 0,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.home,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.time_circle,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.category,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.document,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconlyLight.profile,
                  size: 35,
                ), // Увеличиваем размер иконки
                label: '',
              ),
              ],
            ),
          ),
        );
      },
    );
  }
}