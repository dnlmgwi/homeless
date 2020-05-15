import 'package:homeless/packages.dart';

class LoadingNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Container(
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
                    child: Shimmer.fromColors(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(180.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width / 4,
                                height: 15,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(180.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(180.0),
                              child: Container(
                                color: AppTheme.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                        baseColor: AppTheme.notWhite,
                        highlightColor: AppTheme.nearlyWhite)),
              ))
        ],
      ),
    );
  }
}
