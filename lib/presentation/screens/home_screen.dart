import 'package:duckify/presentation/screens/duck_overview_screen.dart';
import 'package:duckify/presentation/widgets/duck_list_tab.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  final List<String> categories = ['Кураанахтар', 'Уу', 'Хаастар'];
  TabController? _tabController;



  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Кустар куоластара',style: TextStyle(fontSize: 15,color: Colors.amberAccent)),
        backgroundColor: Color(0xFF2E3B2C),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: categories.map((c) => Tab(text: c)).toList(),
          labelColor: Colors.amberAccent,
          unselectedLabelColor: Colors.white70,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.amberAccent,
                width: 3.0,
              ),
            ),
          ),
        )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text('Меню')),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('О приложении'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/forest_background.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          TabBarView(
            controller: _tabController,
            children: categories.map((category) {
              return DuckListTab(category: category);
            }).toList(),
          ),
        ],
      ),
    );
  }
}