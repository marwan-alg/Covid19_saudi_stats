import 'file:///C:/Users/memo_/AndroidStudioProjects/covid_tracker/lib/constant.dart';
import 'file:///C:/Users/memo_/AndroidStudioProjects/covid_tracker/lib/info_screen.dart';
import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  final bool sc;
  const MyHeader(
      {Key key,
      this.image,
      this.textTop,
      this.textBottom,
      this.offset,
      this.sc})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 50, right: 10),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.5, 1],
            colors: [
              Color(0xFF584DA0),
              Color(0xFFFCB439),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5 + widget.offset,
                    left: 230,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return InfoScreen();
                            },
                          ),
                        );
                      },
                      child: widget.sc == true
                          ? Container(
                              width: 90,
                              height: 35,
                              child: Text(
                                'أضغط هنا',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.5, 1],
                                  colors: [
                                    Color(0xFFFCB439),
                                    Color(0xFFEC9439),
                                  ],
                                ),
                              ),
                            )
                          : Container(width: 1),
                    ),
                  ),
                  Positioned(
                    top: 20 + widget.offset,
                    left: 205,
                    child: Container(
                      child: widget.sc == true
                          ? Image.asset('assets/images/pointer.png')
                          : null,
                      width: 50,
                    ),
                  ),
                  Positioned(
                    top: (widget.offset < 0)
                        ? 0
                        : widget.sc == true
                            ? widget.offset
                            : widget.offset + 30,
                    right: 130,
                    child: Image.asset(
                      widget.image,
                      width: widget.sc == true ? 270 : 310,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Positioned(
                    top: widget.sc == true
                        ? 110 + widget.offset
                        : 30 + widget.offset,
                    left: widget.sc == true ? 270 : 220,
                    child: Text(
                      "${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  widget.sc == true
                      ? Positioned(
                          top: 190 + widget.offset,
                          right: 20,
                          child: Container(
                            width: 1,
                          ),
                        )
                      : Positioned(
                          top: 120 + widget.offset,
                          left: 250,
                          child: Container(
                              width: 100,
                              child: Image.asset('assets/images/virus.png')),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
