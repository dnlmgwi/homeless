import 'package:homeless/packages.dart';

class NewsArticleScreen extends StatefulWidget {
  final String content, title, image, source, posted, meta;

  NewsArticleScreen({
    Key key,
    this.content,
    this.title,
    this.image,
    this.posted,
    this.source,
    this.meta,
  }) : super(key: key);
  @override
  _NewsArticleScreenState createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.chipBackground,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        titleSpacing: 1.2,
        centerTitle: false,
        backgroundColor: AppTheme.dark_grey,
        actions: <Widget>[],
        title: AutoSizeText(
          "${widget.title} | ${widget.source}",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 1.2,
            color: AppTheme.nearlyWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  "${widget.image}",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                "${widget.meta}",
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w400,
                  fontSize: 7,
                  color: AppTheme.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(),
              AutoSizeText(
                "${widget.source} • ${widget.posted}",
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: AppTheme.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MarkdownBody(
                data: widget.content,
                fitContent: true,
                selectable: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
