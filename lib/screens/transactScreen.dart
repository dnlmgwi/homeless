import 'package:homeless/packages.dart';

class TransactScreen extends StatefulWidget {
  final String image, name, surname, points, id;
  TransactScreen({
    Key key,
    this.image,
    this.name,
    this.surname,
    this.points,
    this.id,
  }) : super(key: key);
  @override
  _TransactScreenState createState() => _TransactScreenState();
}

class _TransactScreenState extends State<TransactScreen> {
  int _value = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.chipBackground,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          titleSpacing: 1.2,
          centerTitle: false,
          backgroundColor: AppTheme.chipBackground,
          title: Text(
            "Transaction",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 1.2,
              color: AppTheme.dark_grey,
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        title: Text(
                          'Use The Slider to set the Amount',
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.5,
                            letterSpacing: 0.5,
                            color: AppTheme.grey,
                          ),
                        ),
                        leading: Icon(Icons.info_outline)),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
//                                         offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: AppTheme.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "http://www.sketchdm.co.za${widget.image}",
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        AutoSizeText(
                                            "${widget.name} ${widget.surname}",
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25,
                                              letterSpacing: 1,
                                              color: AppTheme.darkerText,
                                            )),
                                        //Name & Age
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText("Current Points".toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontName,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 1,
                                          color: AppTheme.deactivatedText,
                                        )),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(2),
                                          child: AutoSizeText("HL",
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25,
                                                letterSpacing: 1,
                                                color: AppTheme.darkerText,
                                              )),
                                        ),
                                        AutoSizeText(
                                          "${int.parse(widget.points)}",
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 50,
                                            letterSpacing: 1,
                                            color: AppTheme.darkerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              RaisedButton.icon(
                                clipBehavior: Clip.antiAlias,
                                icon: FaIcon(
                                    FontAwesomeIcons.exclamationTriangle,
                                    color: Colors.red),
                                label: Text(
                                  'Report User',
                                  style: TextStyle(
                                    color: AppTheme.darkerText,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0)),
                                color: AppTheme.nearlyWhite,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
//                                         offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                AutoSizeText("Amount to give: ".toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      letterSpacing: 1,
                                      color: AppTheme.deactivatedText,
                                    )),
                                AutoSizeText("HL",
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 9,
                                      letterSpacing: 1,
                                      color: AppTheme.darkerText,
                                    )),
                                AutoSizeText("$_value",
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      letterSpacing: 1,
                                      color: AppTheme.darkerText,
                                    )),
                              ],
                            ),
                          ),
                          Slider(
                              value: _value.toDouble(),
                              min: 10.0,
                              max: 1000.0,
                              divisions: 1000,
                              activeColor: AppTheme.grey,
                              inactiveColor: AppTheme.deactivatedText,
                              onChanged: (double newValue) {
                                setState(() {
                                  _value = newValue.round();
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()} HL';
                              }),
                          FlatButton.icon(
                            padding: EdgeInsets.all(15.0),
                            icon: Icon(Icons.payment, color: AppTheme.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            label: Text("Give"),
                            textColor: AppTheme.white,
                            onPressed: () {
                              //TODO: Transaction
                            },
                            splashColor: AppTheme.nearlyWhite,
                            color: AppTheme.nearlyBlack,
                          )
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
