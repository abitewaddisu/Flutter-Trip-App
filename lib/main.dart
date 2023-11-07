import 'package:flutter/material.dart';
import 'package:trip_app/widgets/rating.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn
    ));
    _animationController.addStatusListener(
      (status) {
        print(status);
        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      }
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> pages = [
    {
      'title': "Yosemite National Park",
      'img_path': 'assets/images/one.jpg',
      'total': 1000,
      'rating': 4,
      'description': 'Yosemite National Park is in California’s Sierra Nevada mountains. It’s famed for its giant, ancient sequoia trees, and for Tunnel View, the iconic vista of towering Bridalveil Fall and the granite cliffs of El Capitan and Half Dome.'
    },
    {
      'title': "Sedona",
      'img_path': 'assets/images/two.jpg',
      'total': 2500,
      'rating': 5,
      'description': 'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'
    },
    {
      'title': "Golden Gate Bridge",
      'img_path': 'assets/images/three.jpg',
      'total': 1500,
      'rating': 3,
      'description': "Sedona is regularly described as one of America's most beautiful places. Nowhere else will you find a landscape as dramatically colorful."
    },
    {
      'title': 'Savannah',
      'img_path': 'assets/images/four.jpg',
      'rating': 4,
      'total': 2100,
      'description': "Savannah, with its Spanish moss, Southern accents and creepy graveyards, is a lot like Charleston, South Carolina. But this city about 100 miles to the south has an eccentric streak."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView.builder(
          onPageChanged: (value) {
            _animationController.reset();
            _animationController.forward();
            print('Working');
          },
          itemCount: 4,
          itemBuilder: (context, index) => SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(pages[index]['img_path']!),
                  fit: BoxFit.cover
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, 0.7],
                    colors: [
                      Colors.black87,
                      Colors.black12,
                    ]
                  )
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                      alignment: Alignment.topRight,
                        child: Text.rich(
                          TextSpan(
                            text: '${index + 1}',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            children: [
                              TextSpan(
                                text: '/4',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            ]
                          )
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pages[index]['title']!, 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 28.0),
                              child: Rating(total: pages[index]['total'], rating: pages[index]['rating']),
                            ),
                            Text(pages[index]['description'], style: TextStyle(color: Colors.white70, fontSize: 20, height: 1.8)),
                            TextButton(onPressed: () {}, child: Text('READ MORE', style: TextStyle(color: Colors.white, fontSize: 20)), style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          )
        ),
      )
    );
  }
}
