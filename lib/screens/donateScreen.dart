// import 'package:homeless/packages.dart';

// class Donate extends StatefulWidget {
//   @override
//   _DonateState createState() => _DonateState();
// }

// class _DonateState extends State<Donate> {
//   final String bankDetails = 'Current Account \n'
//       '00000123456 \n'
//       'First National Bank \n'
//       'Ausspannplatz Branch \n';

//   final String address = 'Erf 3033 \n'
//       'Narraville Municipal Offices \n'
//       'P.O Box 8011 \n'
//       'Walvis Bay \n';

//   int _value = 10;

//   //Allows you to share addess and bank details.
//   shareAdd() {
//     Share.share('$address');
//   }

//   shareBank() {
//     Share.share('$bankDetails');
//   }

//   _pay(BuildContext context) {
//     bool mounted = false;

//     final _rave = RaveCardPayment(
//       isDemo: true,
//       encKey: "c53e399709de57d42e2e36ca",
//       publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
//       transactionRef: "SCH${DateTime.now().millisecondsSinceEpoch}",
//       amount: _value.toDouble(),
//       email: "demo1@example.com",
//       onSuccess: (response) {
//         mounted = true;
//         print("$response");
//         print("Transaction Successful");
//         if (mounted) {
//           Scaffold.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Transaction Sucessful!"),
//               backgroundColor: Colors.green,
//               duration: Duration(
//                 seconds: 5,
//               ),
//             ),
//           );
//         }
//       },
//       onFailure: (err) {
//         print("$err");
//         print("Transaction failed");
//         SnackBar(
//           content: Text('$err'),
//         );
//       },
//       onClosed: () {
//         print("Transaction closed");
//       },
//       context: context,
//     );

//     _rave.process();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppTheme.chipBackground,
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//           titleSpacing: 1.2,
//           centerTitle: false,
//           backgroundColor: AppTheme.chipBackground,
//           title: Text(
//             "Donate",
//             textAlign: TextAlign.left,
//             style: TextStyle(
//               fontFamily: AppTheme.fontName,
//               fontWeight: FontWeight.w700,
//               fontSize: 22,
//               letterSpacing: 1.2,
//               color: AppTheme.dark_grey,
//             ),
//           ),
//         ),
//         body: ListView(
//           children: <Widget>[
//             Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
// //                    SizedBox(
// //                      height: 20,
// //                    ),
// //                    SizedBox(
// //                        width: 500,
// //                        height: 135,
// //                        child: FittedBox(
// //                          fit: BoxFit.fitHeight,
// //                          child: Container(
// //                            padding: EdgeInsets.only(
// //                                top: MediaQuery.of(context).padding.top,
// //                                left: 16,
// //                                right: 16),
// //                            child:
// //                                Image.asset("assets/images/feedbackImage.png"),
// //                          ),
// //                        )),
//                     SizedBox(
//                       height: 9,
//                     ),
//                     ListTile(
//                       title: Text(
//                         'Press & Hold Text To Copy It',
//                         style: TextStyle(
//                           fontFamily: AppTheme.fontName,
//                           fontWeight: FontWeight.normal,
//                           fontSize: 14.5,
//                           letterSpacing: 0.5,
//                           color: AppTheme.grey,
//                         ),
//                       ),
//                       leading: IconButton(
//                           icon: Icon(Icons.info_outline), onPressed: () {}),
//                       onLongPress: () {
//                         Clipboard.setData(ClipboardData(text: bankDetails));
//                         showDialog(
//                             context: context,
//                             builder: (_) => AlertDialog(
//                                   title: Text('Text Copied'),
//                                   content: Text('$bankDetails'),
//                                 ));
//                       },
//                     ),
//                     ListTile(
//                       title: Text(
//                         'Bank Details:',
//                         style: TextStyle(
//                           fontFamily: AppTheme.fontName,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 18,
//                           letterSpacing: 0.5,
//                           color: AppTheme.nearlyBlack,
//                         ),
//                       ),
//                       subtitle: Text(
//                         '$bankDetails',
//                         style: TextStyle(
//                           fontFamily: AppTheme.fontName,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16,
//                           letterSpacing: 0.5,
//                           color: AppTheme.nearlyBlack,
//                         ),
//                       ),
//                       trailing: IconButton(
//                           icon: Icon(Icons.share),
//                           onPressed: shareBank,
//                           color: AppTheme.dark_grey),
//                       onLongPress: () {
//                         Clipboard.setData(ClipboardData(text: bankDetails));
//                         showDialog(
//                             context: context,
//                             builder: (_) => AlertDialog(
//                                   title: Text('Text Copied'),
//                                   content: Text('$bankDetails'),
//                                 ));
//                       },
//                     ),
//                     SizedBox(
//                       height: 9,
//                     ),
//                     ListTile(
//                         title: Text(
//                           'Address:',
//                           style: TextStyle(
//                             fontFamily: AppTheme.fontName,
//                             fontWeight: FontWeight.w900,
//                             fontSize: 18,
//                             letterSpacing: 0.5,
//                             color: AppTheme.nearlyBlack,
//                           ),
//                         ),
//                         subtitle: Text('$address',
//                             style: TextStyle(
//                               fontFamily: AppTheme.fontName,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16,
//                               letterSpacing: 0.5,
//                               color: AppTheme.nearlyBlack,
//                             )),
//                         trailing: IconButton(
//                             icon: Icon(Icons.share),
//                             onPressed: shareAdd,
//                             color: AppTheme.dark_grey),
//                         onLongPress: () {
//                           Clipboard.setData(ClipboardData(text: address));
//                           showDialog(
//                               context: context,
//                               builder: (_) => AlertDialog(
//                                     title: Text('Text Copied'),
//                                     content: Text('$address'),
//                                   ));
//                         }),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     ListTile(
//                       title: Text(
//                         'Amount To Donate: NAD $_value',
//                         style: TextStyle(
//                           fontFamily: AppTheme.fontName,
//                           fontWeight: FontWeight.w900,
//                           fontSize: 18,
//                           letterSpacing: 0.5,
//                           color: AppTheme.nearlyBlack,
//                         ),
//                       ),
//                     ),
//                     Slider(
//                         value: _value.toDouble(),
//                         min: 10.0,
//                         max: 1000.0,
//                         divisions: 1000,
//                         activeColor: AppTheme.grey,
//                         inactiveColor: AppTheme.deactivatedText,
//                         onChanged: (double newValue) {
//                           setState(() {
//                             _value = newValue.round();
//                           });
//                         },
//                         semanticFormatterCallback: (double newValue) {
//                           return '${newValue.round()} Namibian dollars';
//                         }),
//                     FlatButton.icon(
//                       icon: Icon(Icons.payment, color: AppTheme.white),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(50.0),
//                       ),
//                       label: Text("Donate"),
//                       textColor: AppTheme.white,
//                       onPressed: () {
//                         _pay(context);
//                       },
//                       splashColor: AppTheme.nearlyWhite,
//                       color: AppTheme.nearlyBlack,
//                     )
//                   ],
//                 ))
//           ],
//         ));
//   }
// }
