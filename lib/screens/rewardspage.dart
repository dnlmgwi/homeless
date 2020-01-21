import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeless/api/network.dart';
import 'package:homeless/model/BlockWidgetModel.dart';
import 'package:homeless/model/rewards/rewards.dart';
import 'package:homeless/model/rewards/settingsRewards.dart';
import 'package:homeless/packages.dart';

class RewardsScreen extends StatefulWidget {
  RewardsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String _currText = '';

  Network api = Network();

  Rewards rewardsList = Rewards();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewardData();
  }

  void getRewardData() async {
    var onValue = await api.getData();
    if (onValue == null) {
      CircularProgressIndicator(
        backgroundColor: AppTheme.dark_grey,
        strokeWidth: 5,
      );
    } else {
      setState(() {
        rewardsList = Rewards.fromJson(onValue);
        return rewardsList.settingsRewards;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.chipBackground,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            titleSpacing: 1.2,
            centerTitle: false,
            backgroundColor: AppTheme.dark_grey,
            title: Text(
              "Rewards",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                letterSpacing: 1.2,
                color: AppTheme.nearlyWhite,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemBuilder: (context, int) {
                return ListTile(
                  trailing: Text(
                      'HL: ${rewardsList.settingsRewards[int].fields.punchCost}',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        letterSpacing: 1.2,
                        color: AppTheme.dark_grey,
                      )),
                  subtitle: Text(
                      '${rewardsList.settingsRewards[int].fields.description}',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: AppTheme.dark_grey,
                      )),
                  title: Text(
                      "${rewardsList.settingsRewards[int].fields.rewardName}",
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        color: AppTheme.darkerText,
                      )),
                );
              },
              itemCount: (rewardsList == null ||
                      rewardsList.settingsRewards == null ||
                      rewardsList.settingsRewards.length == 0)
                  ? 0
                  : rewardsList.settingsRewards.length,
            ),
          ),
        ),
      ),
    );
  }
}
