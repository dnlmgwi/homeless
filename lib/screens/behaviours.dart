import 'package:homeless/models/behaviours/behaviours.dart';
import 'package:homeless/packages.dart';

class BehavioursScreen extends StatefulWidget {
  @override
  _BehavioursScreenState createState() => _BehavioursScreenState();
}

class _BehavioursScreenState extends State<BehavioursScreen> {
//  String _currText = '';

  Network api = Network();

  Behaviours behavioursList = Behaviours();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBehaviourData();
  }

  //This Method Launches the alert Dialogue for an API Error
  _alert({context, error}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Network Error"),
            alertSubtitle: richSubtitle("$error"),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              RaisedButton(
                child: Text('Try Again'),
                onPressed: () => Navigator.pop(context), //closes the dialogue
              )
            ],
          );
        });
  }

  //This Method getBehaviour data using the API and Changes the UI State.
  void getBehaviourData() async {
    var onValue = await api.getRewardData().catchError((onError) {
      _alert(context: context, error: onError);
    });
    setState(() {
      behavioursList = Behaviours.fromJson(onValue);
      return behavioursList.settingsBehaviours.basicPunch;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool active = behavioursList.settingsBehaviours.basicPunch.active == 'true';

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
                    getBehaviourData();
                  })
            ],
            title: Text(
              "Behaviours",
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
            child: Column(
              children: <Widget>[
                ListTile(
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
                      Text(
                          '${behavioursList.settingsBehaviours.basicPunch.punch}',
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
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
                  subtitle: Text(
                      'Users are not allow to award no more than ${behavioursList.settingsBehaviours.basicPunch.fields.noMoreThan} ${behavioursList.settingsBehaviours.basicPunch.fields.unit}, only ${behavioursList.settingsBehaviours.basicPunch.fields.multiPunch} can award points multiple times',
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: AppTheme.deactivatedText,
                      )),
                  title: Text("Basic Awards",
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        letterSpacing: 1.7,
                        color: AppTheme.darkerText,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
