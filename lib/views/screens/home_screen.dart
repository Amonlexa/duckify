import 'package:duckify/controllers/duck_audio_cubit.dart';
import 'package:duckify/controllers/duck_audio_state.dart';
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
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Кураанахтар'),
    Tab(text: 'Уу'),
    Tab(text: 'Хаастар'),
  ];
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<DuckAudioCubit>().loadSounds(myTabs[_tabController.index].text!);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DuckAudioCubit>().loadSounds(myTabs.first.text.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingMediaControl(),
      appBar: AppBar(
          title: Text('Кустар куоластара', style: TextStyle(fontSize: 15, color: Colors.amberAccent)),
          backgroundColor: Color(0xFF2E3B2C),
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
            children: myTabs.map((Tab tab) {
              return BlocBuilder<DuckAudioCubit, DuckAudioState>(
                buildWhen: (prev, current) => current.category == tab.text || prev.category == tab.text,
                builder: (context, state) {
                  if (state is DuckCallLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is DuckCallLoaded) {
                    return DuckListTab(ducks: state.ducks);
                  }
                  if (state is DuckCallError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          ElevatedButton(
                            onPressed: () => context.read<DuckAudioCubit>().loadSounds(tab.text.toString()),
                            child: Text('Повторить'),
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}