import 'package:homeless/packages.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
//  String _currText = '';

  Network api = Network();

  News newsList = News();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsData();
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

  void getNewsData() async {
    var onValue = await api.getNews().catchError((onError) {
      _alert(context: context, error: onError);
    });
    setState(() {
      isLoading = false;
      newsList = News.fromJson(onValue);
      return newsList.items;
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
          return ListTile(
            onTap: () {},
            subtitle: Text('${newsList.items[int].url}',
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: AppTheme.deactivatedText,
                )),
            title: Text("${newsList.items[int].title}",
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 1,
                  color: AppTheme.darkerText,
                )),
          );
        },
        itemCount: (newsList == null ||
                newsList.items == null ||
                newsList.items.length == 0)
            ? 0
            : newsList.items.length,
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
                    getNewsData();
                  })
            ],
            title: Text(
              "News",
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
