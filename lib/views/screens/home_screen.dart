import 'package:duckify/controllers/constans.dart';
import 'package:duckify/controllers/duck_audio_cubit.dart';
import 'package:duckify/controllers/duck_audio_state.dart';
import 'package:duckify/views/screens/about_screen.dart';
import 'package:duckify/views/widgets/duck_list_tab.dart';
import 'package:duckify/views/widgets/floating_media_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static const List<Tab> myTabs = <Tab>[Tab(text: 'Кураанахтар'), Tab(text: 'Уу'), Tab(text: 'Хаастар')];
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    // Предзагрузка всех табов и инициализация таба
    _tabController = TabController(vsync: this, length: myTabs.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categories = myTabs.map((t) => t.text!).toList();
      context.read<DuckAudioCubit>().preloadAllCategories(categories);
    });
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      floatingActionButton: FloatingMediaControl(),
      appBar: AppBar(
          title: Text('Кустар саҥалара', style: TextStyle(fontSize: 15, color: Colors.amberAccent)),
          backgroundColor: Constants.backgroundColor,
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
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
      // drawer: Drawer(
      //   backgroundColor: Constants.backgroundColor,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(child: Column(
      //         children: [
      //           Text('Duckify - Кустар саҥалара',style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold)),
      //           const SizedBox(height: 10),
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(8),
      //             child: Image.asset(
      //               "assets/images/playstore.png",
      //               width: 100,
      //               height: 100,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ],
      //       )),
      //       ListTile(
      //         leading: Icon(Icons.info,color: Colors.white,),
      //         title: Text('Проект туhунан',style: TextStyle(color: Colors.white, fontSize: 16)),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
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
          BlocBuilder<DuckAudioCubit, DuckAudioState>(
            buildWhen: (prev, current) {
              return current is DuckCallLoaded;
            },
            builder: (context, state) {
              if (state is DuckCallLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DuckCallLoaded) {
                return TabBarView(
                  controller: _tabController,
                  children: myTabs.map((Tab tab) {
                    final ducks = context.read<DuckAudioCubit>().getDucksByCategory(tab.text!);
                    return DuckListTab(ducks: ducks!);
                  }
                  ).toList()
                );
              }
              if (state is DuckCallError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}