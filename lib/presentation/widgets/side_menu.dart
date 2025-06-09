import 'package:flutter/material.dart';
import 'package:gastos_flutter/presentation/screens/category_management_screen.dart';
import 'package:gastos_flutter/presentation/screens/tag_management_screen.dart';



class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => (value == 0)
            ? const CategoryManagementScreen()
            : const TagManagementScreen()
          )
        );
        widget.scaffoldKey.currentState?.closeDrawer();
      },

      children: [
        Container(
          color: colors.primary,
          width: double.infinity,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: const Text('Menu', style: TextStyle(color: Colors.white, fontSize: 40),)
          )
        ),

        SizedBox(height: 15,),

        NavigationDrawerDestination(
          icon: Icon(Icons.category),
          label: Text('Manage Categories')
        ),

        NavigationDrawerDestination(
          icon: Icon(Icons.tag),
          label: Text('Manage Tags')
        )
        
      ]
    );
  }
}