import 'package:homeless/packages.dart';
part 'news.g.dart';

/*

Sample Response

        {
            "id": "http://www.sketchdm.co.za/dr-jkm-foundation/",
            "url": "http://www.sketchdm.co.za/dr-jkm-foundation/",
            "title": "Dr. JKM Foundation",
            "summary": "The LogoThe Logo was designed to express the foundations main objectives. I continuously revised the concept I had started with even before attempting to design the logo, I tackled that this by setting the goals&hellip;",
            "content_html": "<h2 id=\"mcetoc_1dvhs41mh1\">The Logo</h2>\n<figure class=\"post__image\">\n<figure class=\"post__image\">\n<figure class=\"post__video\"><iframe width=\"560\" height=\"314\" src=\"https://www.youtube.com/embed/MJH7PU9qSxM\" allowfullscreen=\"allowfullscreen\" ></iframe></figure>\n<p>The Logo was designed to express the foundations main objectives.</p>\n<ul>\n<li>The Key - Unlocking Opportunity.</li>\n<li>The Flag – Upholding the identity of the medical field.</li>\n<li>The Shield – Protecting the quality of healthcare.</li>\n</ul>\n<p>I continuously revised the concept I had started with even before attempting to design the logo, I tackled that this by setting the goals earlier in process and reminding myself that this would be an emblem that would be true to me and to the organisation and it goals.<img src=\"undefined\" alt=\"\"></p>\n</figure>\n</figure>\n<h2 id=\"mcetoc_1dvhs48ek2\">The Organisation</h2>\n<p>The Dr. Jeremiah Killion Mgawi ('JKM') Foundation (\"Foundation'), was founded in commemoration of the late doctor’s 60th birthday celebration in 2019, also marking 20 years since his demise at the age of 40. The Foundation was duly incorporated as a Trust under the Trustees Incorporation Act of Malawi.</p>\n<h4 id=\"mcetoc_1dvhs2pnn0\">Objectives of the Foundation:</h4>\n<ul>\n<li>To raise funds for purposes of offering scholarships or grants for medical students in Malawi.</li>\n<li>To provide for mentorship programmes to medical students with the aim of equipping and training them for work in their communities, with the aim of reducing brain drain and encouraging patriotic medical doctors.</li>\n<li>Raise awareness on the importance of health related issues and to reach out to vulnerable communities through community engagement programmes in plight towards quality health care systems.</li>\n</ul>\n<h4 id=\"mcetoc_1dvhqgeva1\">Mission of the Foundation:</h4>\n<p id=\"mcetoc_1dvhqi3gt6\">The Foundation seeks to train and equip more than 40 medical students, majoring in Bachelor of Medicine and Surgery through the Malawi College of Medicine.</p>\n<h4 id=\"mcetoc_1dvhqpisb7\">Contact Us</h4>\n<ul>\n<li>Website: <a href=\"http://drjkmfoundation.online/\" target=\"_blank\" rel=\"noopener noreferrer\">Dr. J.K Mgawi Foundation</a></li>\n<li>Post Office Box 31549, Lilongwe 3, Malawi</li>\n<li>Mobile: +265 99 8154687 / +265 99 8159596</li>\n<li>Email: <a href=\"mailto:info@drjkmfoundation.online\">info@drjkmfoundation.online</a></li>\n</ul>",
            "image": "http://www.sketchdm.co.za/media/posts/16/banner.jpg",
            "author": {
                "name": "Daniel Mgawi"
            },
            "tags": [
                   "Graphic Design"
            ],
            "date_published": "2020-01-26T22:59:48+02:00",
            "date_modified": "2020-01-26T23:49:28+02:00"
        },
 */

@JsonSerializable(explicitToJson: true)
class News {
  String version, title, description;

  @JsonKey(name: 'home_page_url')
  String homePageUrl;

  @JsonKey(name: 'feed_url')
  String feedUrl;

  @JsonKey(name: 'user_comment')
  String userComment;

  Author author;

  List<Items> items;

  News({
    this.version,
    this.title,
    this.description,
    this.homePageUrl,
    this.feedUrl,
    this.userComment,
    this.author,
    this.items,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
