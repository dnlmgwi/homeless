import 'package:homeless/model/rewards/settingsRewards.dart';
import 'package:homeless/packages.dart';
import 'package:homeless/services/UserRepo.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  List<Widget> widgets = [];

  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    createList();
  }

  List<Widget> createList() {
    _userRepository.rewardsCheck().then((onValue) {
      for (SettingsRewards data in onValue) {
        print('${data.fields.length}');
      }
    });

    return widgets;
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
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
                  height: 200.0,
                  child: Column(
                    children: widgets,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
