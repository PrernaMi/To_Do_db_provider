import 'package:flutter/material.dart';
import 'package:todo_db_provider/navigation/bottom_pages/explore.dart';

import 'navigation/bottom_pages/home.dart';

class BottomNavigationPage extends StatefulWidget{
  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPage();
}

class _BottomNavigationPage extends State<BottomNavigationPage> {

  List<Widget> navPages = [
    Home(),
    ExplorePage()
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentPage == 0? Center(child: Text("Home Page")) : Center(child: Text("Explore more..")),
        leading: Icon(Icons.account_circle,size: 30,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 30,)),
          PopupMenuButton(
            position: PopupMenuPosition.under,
              itemBuilder: (_){
            return [
              PopupMenuItem(
                onTap: (){},
                  child: Row(
                    children: [
                      Icon(Icons.notifications,size: 30,),
                      Text("Notifications",)
                    ],
                  )
              ),
              PopupMenuItem(
                onTap: (){},
                  child: Row(
                    children: [
                      Icon(Icons.logout,size: 30,),
                      Text("Logout",)
                    ],
                  )
              )
            ];
          })
        ],
      ),
      body: navPages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home,size: 30,),
              icon: Icon(Icons.home_outlined,size: 30,),
              label: "Home"
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.explore,size: 30,),
              icon: Icon(Icons.explore_outlined,size: 30,),
              label: "Explore"
          ),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (value){
          currentPage = value;
          setState(() {

          });
        },
      ),
    );
  }
}