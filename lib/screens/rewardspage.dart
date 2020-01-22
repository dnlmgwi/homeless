import 'package:homeless/packages.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
//  String _currText = '';

  Network api = Network();

  Rewards rewardsList = Rewards();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewardData();
  }

  //This Method Launches the alert Dialogue for an API Error
  _alert({context, error}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Network Error"),
            alertSubtitle: richSubtitle(
                "This feature requires internet access.\n Please turn on mobile data or Wifi"),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              RaisedButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/dash');
                }, //closes the dialogue
              )
            ],
          );
        });
  }

  void getRewardData() async {
    var onValue = await api.getRewardData().catchError((onError) {
      _alert(context: context, error: onError);
    });
    setState(() {
      isLoading = false;
      rewardsList = Rewards.fromJson(onValue);
      return rewardsList.settingsRewards;
    });
  }

  Widget _handleCurrentScreen(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 9,
          backgroundColor: AppTheme.dark_grey,
        ),
      );
    } else {
      return ListView.separated(
        separatorBuilder: (context, int) {
          return Divider();
        },
        itemBuilder: (context, int) {
          bool active = rewardsList.settingsRewards[int].active == 'true';

          return ListTile(
            enabled: active,
            onTap: () {},
            leading: active
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('${rewardsList.settingsRewards[int].fields.punchCost}',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: AppTheme.dark_grey,
                    )),
                Text('HL Points',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      letterSpacing: 1.2,
                      color: AppTheme.lightText,
                    )),
              ],
            ),
            subtitle:
                Text('${rewardsList.settingsRewards[int].fields.description}',
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: AppTheme.deactivatedText,
                    )),
            title: Text("${rewardsList.settingsRewards[int].fields.rewardName}",
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 1,
                  color: AppTheme.darkerText,
                )),
          );
        },
        itemCount: (rewardsList == null ||
                rewardsList.settingsRewards == null ||
                rewardsList.settingsRewards.length == 0)
            ? 0
            : rewardsList.settingsRewards.length,
      );
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
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    getRewardData();
                  })
            ],
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
              child: _handleCurrentScreen(isLoading)),
        ),
      ),
    );
  }
}
