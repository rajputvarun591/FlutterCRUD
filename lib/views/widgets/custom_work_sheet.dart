import 'package:flutter/material.dart';

class CustomWorkSheet extends StatefulWidget {
  @override
  _CustomWorkSheetState createState() => _CustomWorkSheetState();
}

class _CustomWorkSheetState extends State<CustomWorkSheet> {

  List<BottomNavBarModel> list;
  int currentIndex = 3;

  @override
  void initState() {
    super.initState();
    list = [
      BottomNavBarModel(Icons.four_k, Icons.add),
      BottomNavBarModel(Icons.keyboard, Icons.add),
      BottomNavBarModel(Icons.radio_button_unchecked, Icons.add),
      BottomNavBarModel(Icons.style, Icons.add),
      BottomNavBarModel(Icons.radio_button_unchecked, Icons.add),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          //color: Colors.green.withOpacity(0.5),
          height:  MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      bottomNavigationBar: _bottom(),
    );
  }

  _bottom() {
    final mediaQuery = MediaQuery.of(context);
    return CustomPaint(
      painter: MyCustomPainter(list.length, currentIndex),
      child: Container(
        height: mediaQuery.size.height * 0.1,
        child: Stack(
          children: [
            Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(1 - 0.2) * 80,
                ),
                child: Material(
                  color: Colors.green,
                  type: MaterialType.circle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                ),
              ),
            ),
            BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: list.map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon1),
                  title: Center(),
                activeIcon: Container(

                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle

                  ),
                    //padding: EdgeInsets.all(5.00),
                    //margin: EdgeInsets.only(bottom: 5.00),
                    child: Align(alignment: Alignment.topCenter, child: Icon(e.icon2, color: Colors.white, size: 40.00,)))
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

}

class MyCustomPainter extends CustomPainter{


  final int length;
  final int index;


  MyCustomPainter(this.length, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.00
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(size.width/length * index - 30.00, 0.0)
      ..cubicTo(((size.width/length * index) + size.width/length/2) -10.00, size.height * 0.05, ((size.width/length * index) + size.width/length * 0.2) - 20, size.height * 0.9, ((size.width/length * index) + size.width/length/2) , size.height * 0.9)
      ..cubicTo(((size.width/length * index) + size.width/length * 0.8) +20, size.height * 0.9, ((size.width/length * index) + size.width/length/2) + 10, size.height * 0.05, ((size.width/length * index) + size.width/length) +30.00, 0.0)
      ..lineTo(size.width , 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class BottomNavBarModel {
  final IconData icon1;
  final IconData icon2;

  BottomNavBarModel(this.icon1, this.icon2);
}