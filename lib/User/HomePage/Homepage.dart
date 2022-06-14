import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:star_event/Custom%20icons/icons_icons.dart';
import 'package:star_event/Custom%20icons/icons_iconss.dart';
import 'package:star_event/User/Calender/UserEventCalender.dart';
import 'package:star_event/User/Favourite/UserFavouritestars.dart';
import 'package:star_event/User/HomePage/UserHomePageFromJson.dart';
import 'package:star_event/User/ProfilePage/UserProfile.dart';

class Homepage extends StatefulWidget {
  static final routeName = '/superAdminHome';
  int index;
  Homepage(this.index);

  @override
  _HomepageState createState() => _HomepageState(index);
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final LocalStorage storage = new LocalStorage('Star');
  int index;
  _HomepageState(this.index);

  Color _colorFromHex(String hexColor) {
    var hexCode = hexColor.replaceAll('Color(0x', '');
    hexCode = hexCode.replaceAll(')', '');
    return Color(int.parse('$hexCode', radix: 16));
  }

  String title = 'BottomNavigationBar';

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final tabs = [
            UserHomeJson(),
            UserFavouriteStar(),
            UserEventCalender(),
            UserProfilePage(),
          ];
          return Scaffold(
            body: TabBarView(
              children: <Widget>[
                UserHomeJson(),
                UserFavouriteStar(),
                UserEventCalender(),
                UserProfilePage(),
              ],
              // If you want to disable swiping in tab the use below code

              controller: _tabController,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    //background color of box

                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: Colors.deepOrangeAccent,
                      enableFeedback: true,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 10.0),
                      indicatorColor: Colors.white,
                      tabs: <Widget>[
                        Tab(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              CIcons.home,
                              size: 22.0,
                            ),
                          ),
                          text: 'Home',
                        ),
                        Tab(
                          icon: Icon(
                            CupertinoIcons.heart,
                            size: 22.0,
                          ),
                          text: 'Favourite',
                        ),
                        Tab(
                          icon: Icon(
                            CIcons.calender,
                            size: 22.0,
                          ),
                          text: 'Calender',
                        ),
                        Tab(
                          icon: Icon(
                            CustomIcons.settings_1,
                            size: 22.0,
                          ),
                          text: 'Settings',
                        ),
                      ],
                      controller: _tabController,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}

const String _svg_ap7v5k =
    '<svg viewBox="503.0 541.9 18.7 11.8" ><path transform="translate(-2.54, -6.44)" d="M 507.081298828125 558.5274047851562 L 510.91162109375 558.5274047851562 C 510.91162109375 557.735595703125 510.9072265625 556.9638061523438 510.9129028320312 556.19140625 C 510.9172973632812 555.5084228515625 510.88330078125 554.8204956054688 510.9512939453125 554.1431884765625 C 511.1665649414062 551.9960327148438 512.9127807617188 550.4229736328125 514.9736328125 550.4752197265625 C 517.123291015625 550.5293579101562 518.8240966796875 552.2232666015625 518.8889770507812 554.4295654296875 C 518.927978515625 555.767822265625 518.8958740234375 557.1085205078125 518.8958740234375 558.509765625 L 522.697265625 558.509765625 C 522.7098388671875 558.2459716796875 522.733154296875 557.9791259765625 522.7337646484375 557.7122802734375 C 522.7362670898438 555.0281982421875 522.7349853515625 552.3447265625 522.7362670898438 549.66064453125 C 522.7362670898438 549.4334716796875 522.6651000976562 549.1513671875 522.771484375 548.9903564453125 C 522.9470825195312 548.7252197265625 523.2650146484375 548.34130859375 523.4790649414062 548.3677368164062 C 523.7572631835938 548.4017333984375 524.0833129882812 548.7447509765625 524.2192993164062 549.0350341796875 C 524.346435546875 549.3056640625 524.2551879882812 549.68017578125 524.2551879882812 550.0094604492188 C 524.2557983398438 552.9969482421875 524.2576904296875 555.984375 524.25390625 558.9718017578125 C 524.252685546875 559.8776245117188 524.048095703125 560.0853271484375 523.1347045898438 560.0903930664062 C 521.5900268554688 560.0985107421875 520.0458984375 560.0985107421875 518.5017700195312 560.0903930664062 C 517.5859375 560.0853271484375 517.3838500976562 559.8795166015625 517.3807373046875 558.9737548828125 C 517.3750610351562 557.581298828125 517.3832397460938 556.1889038085938 517.3776245117188 554.7965087890625 C 517.3712768554688 553.1385498046875 516.387451171875 552.014892578125 514.9327392578125 551.994140625 C 513.4572143554688 551.97265625 512.4431762695312 553.112060546875 512.4337158203125 554.8160400390625 C 512.4261474609375 556.2084350585938 512.4381103515625 557.600830078125 512.4293212890625 558.9932861328125 C 512.4242553710938 559.866943359375 512.2183837890625 560.0828857421875 511.3617553710938 560.089111328125 C 509.7918090820312 560.1004638671875 508.221923828125 560.1004638671875 506.6526489257812 560.089111328125 C 505.8041381835938 560.0828857421875 505.5655517578125 559.843017578125 505.5636596679688 559.0020751953125 C 505.557373046875 555.8118286132812 505.56494140625 552.6217041015625 505.5579833984375 549.4321899414062 C 505.5567626953125 548.8744506835938 505.6536865234375 548.3463134765625 506.3121337890625 548.3369140625 C 507.0391845703125 548.326171875 507.0869750976562 548.896484375 507.0850830078125 549.4718627929688 C 507.0762939453125 552.1810913085938 507.081298828125 554.8896484375 507.081298828125 557.5989990234375 C 507.081298828125 557.8759765625 507.081298828125 558.1535034179688 507.081298828125 558.5274047851562 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_3xbdtw =
    '<svg viewBox="498.7 530.9 27.3 11.8" ><path  d="M 512.3925170898438 532.635009765625 C 509.4446411132812 534.983642578125 506.5547790527344 537.286865234375 503.6648559570312 539.5894775390625 C 502.5160827636719 540.5047607421875 501.3654174804688 541.4174194335938 500.2191467285156 542.335205078125 C 499.7854309082031 542.6826782226562 499.3101806640625 542.9130859375 498.8903198242188 542.4013061523438 C 498.4553527832031 541.8699951171875 498.8248596191406 541.4803466796875 499.2547912597656 541.1386108398438 C 503.3753356933594 537.8584594726562 507.4989929199219 534.5814208984375 511.6043701171875 531.2828979492188 C 512.15771484375 530.8385620117188 512.58447265625 530.8253173828125 513.1390380859375 531.2710571289062 C 517.2450561523438 534.5693969726562 521.373779296875 537.8402099609375 525.4697265625 541.1505737304688 C 525.74609375 541.3734130859375 525.9902954101562 541.8674926757812 525.9500122070312 542.1992797851562 C 525.87890625 542.7916259765625 525.2380981445312 542.8671264648438 524.6331787109375 542.3880615234375 C 522.5697631835938 540.7520751953125 520.513916015625 539.1060180664062 518.4548950195312 537.46435546875 C 516.4569702148438 535.871826171875 514.457763671875 534.280517578125 512.3925170898438 532.635009765625 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
