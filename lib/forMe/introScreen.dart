import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;
  final List<String> titles = [
    "Welcome To Hero Bus",
    "Organization              ",
    "The Smile                     ",
    "Abide By Traffic Rules",
  ];
  final List<String> subtitles = [
    "Welcome to your safer and more comfortable Application .",
    "we work to organize students and teach them to order and place seat belts.",
    "Draw a smile on the students' face in the morning and treat them kindly.",
    "Work to help traffic officers in the system and estimate the correct time for students to arrive at schools."
  ];
  final List<Color> colors = [
    //Colors.yellow[400],
    //Color(0xffb95103B),
    //Color(0xffb323639),
    Color(0xffbF4F4F4),
    Color(0xffbF4F4F4),
    Color(0xffbF4F4F4),
    Color(0xffbF4F4F4),
  ];
  final List<String> imagesUrl = [
    "assets/images/4.png",
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg"
  ];
  String pngImage = "assets/images/4.png";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Swiper(
              //autoplay: true, //
              //autoplayDelay: 5000,
              loop: false, //false
              //autoplayDisableOnInteraction: true,
              index: _currentIndex,
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              controller: _controller,
              pagination: SwiperPagination(
                builder: RectSwiperPaginationBuilder(
                  activeSize: Size(10.0, 23.0),
                  size: Size(10.0, 15.0),
                  color: Colors.grey.shade600,
                  activeColor: Colors.indigo[600], //Color(0xffb95103B),
                ),
                /*  DotSwiperPaginationBuilder(
                  activeColor: Colors.indigo[600],
                  activeSize: 15.0,
                  color: Colors.grey[700],
                ), */
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return IntroItem(
                  title: titles[index],
                  subtitle: subtitles[index],
                  bg: Color(0xffbF4F4F4),
                  imageUrl: imagesUrl[index],
                  textColor: Colors.black,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Login');
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                    _currentIndex == 3 ? Icons.check : Icons.arrow_forward),
                onPressed: () {
                  if (_currentIndex != 3) {
                    _controller.next();
                  } else {
                    Navigator.of(context).pushNamed('/Login');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bg;
  final String imageUrl;
  final Color textColor;

  const IntroItem(
      {Key key,
      @required this.title,
      this.subtitle,
      this.bg,
      this.imageUrl,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg ?? Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: textColor),
                textAlign: TextAlign.left,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 20.0),
                Text(
                  subtitle,
                  style: TextStyle(color: textColor, fontSize: 24.0),
                  textAlign: TextAlign.left,
                ),
              ],
              const SizedBox(height: 40.0),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Material(
                      elevation: 4.0,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
