import 'package:homeless/packages.dart';

class LoadingProfile extends StatelessWidget {
  const LoadingProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20.0),
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
          child: Shimmer.fromColors(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(180.0),
                    child: Container(
                      color: AppTheme.grey,
                      width: 180,
                      height: 180,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    color: AppTheme.grey,
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height: 15,
                                  ),
                                ), //Name & Age
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width / 6,
                                height: 10,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    color: AppTheme.grey,
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    color: AppTheme.grey,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height: 20,
                                  ),
                                ),

                                Spacer(),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    color: AppTheme.grey,
                                    width: 50,
                                    height: 20,
                                  ),
                                ),
                                // Date Joined
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Wrap(
                                direction: Axis.vertical,
                                spacing: 9,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 10,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 10,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 10,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 10,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 10,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width / 8,
                                height: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width / 10,
                                height: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      color: AppTheme.grey,
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    color: AppTheme.grey,
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              baseColor: AppTheme.notWhite,
              highlightColor: AppTheme.nearlyWhite),
        ),
      ],
    );
  }
}
