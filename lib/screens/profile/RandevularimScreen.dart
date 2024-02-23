import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/widgets/appbar/appbar.dart';

class RandevularimScreen extends StatefulWidget {
  const RandevularimScreen({super.key});

  @override
  State<RandevularimScreen> createState() => _RandevularimScreenState();
}

class _RandevularimScreenState extends State<RandevularimScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MateBar(
          "Randevularım", true, Theme.of(context).colorScheme.secondary,
          height: 100,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorColor: Theme.of(context).colorScheme.secondary,
                indicatorPadding: EdgeInsets.all(1),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                dividerColor: Colors.transparent,
                labelColor: Theme.of(context).colorScheme.secondary,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                controller: _tabController,
                tabs: [
                  Tab(text: "Gelecek Randevularım"),
                  Tab(text: "Geçmiş Randevularım")
                ]),
          )),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              Column(
                children: [Text("Geleceğini")],
              ),
              Column(
                children: [Text("Gideceğini")],
              )
            ]),
          )
        ],
      ),
    );
  }
}
