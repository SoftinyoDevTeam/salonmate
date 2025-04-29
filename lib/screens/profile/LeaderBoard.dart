import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:salonmate/core/functions.dart';
import 'package:easy_localization/easy_localization.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<Map<String, dynamic>> topScorers = [];
  List<Map<String, dynamic>> newMembers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaderboardData();
  }

  Future<void> fetchLeaderboardData() async {
    final url = 'https://salonmate.co/inc/api.php?module=leaderboard';
    try {
      final response = await Dio().post(
        options: Options(headers: {
          "Access-Control-Allow-Origin": "*",
          "Matekey": await getPrefString("token"),
        }),
        url,
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "200") {
          setState(() {
            topScorers =
                List<Map<String, dynamic>>.from(data['data']['scorer']);
            newMembers =
                List<Map<String, dynamic>>.from(data['data']['longermember']);
            isLoading = false;
          });
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to load leaderboard data');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching leaderboard data: $error');
    }
  }

  String calculateTimeSinceRegistration(String registerDate) {
    final registerDateTime = DateTime.parse(registerDate);
    final now = DateTime.now();
    final duration = now.difference(registerDateTime);
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final parts = [];
    if (days > 0) parts.add('$days gün');
    if (hours > 0) parts.add('$hours saat');
    if (minutes > 0) parts.add('$minutes dakika');
    if (seconds > 0) parts.add('$seconds saniye');

    return parts.isNotEmpty ? parts.join(' ') : 'Şimdi';
  }

  Widget buildList(List<Map<String, dynamic>> data,
      {bool showTimeSinceRegistration = false}) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final user = data[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              user['fullName'],
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '@${user['ID']}',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  showTimeSinceRegistration
                      ? calculateTimeSinceRegistration(user['registerDate'])
                      : user['points'].toString(),
                  style: TextStyle(color: Colors.white),
                ),
                if (!showTimeSinceRegistration) ...[
                  SizedBox(width: 8),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                ],
                if (showTimeSinceRegistration) ...[
                  SizedBox(width: 8),
                  Icon(
                    Icons.timer_rounded,
                    color: Colors.amber,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ProfileScreen.leaderboard'.tr()), // Localized title
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: fetchLeaderboardData,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'ProfileScreen.top_scorers'.tr()), // Localized tab
              Tab(text: 'ProfileScreen.new_members'.tr()), // Localized tab
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  buildList(topScorers),
                  buildList(newMembers, showTimeSinceRegistration: true),
                ],
              ),
      ),
    );
  }
}
