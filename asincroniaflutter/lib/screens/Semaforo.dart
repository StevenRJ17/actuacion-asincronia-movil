import 'package:flutter/material.dart';
import 'package:asincroniaflutter/services/mockapi.dart';

class Semaforo extends StatefulWidget {
  const Semaforo({Key? key}) : super(key: key);

  @override
  State<Semaforo> createState() => _SemaforoState();
}

class _SemaforoState extends State<Semaforo> with TickerProviderStateMixin {
  String nRandom1 = '';
  bool cargando = false;
  double progressValue = 0.0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  String nRandom2 = '';
  bool cargandonRandom2 = false;

  late AnimationController _animationControllernRandom2;
  late Animation<double> _animationnRandom2;

  bool cargandonRandom3 = false;
  String nRandom3 = '';
  
  late AnimationController _animationControllerFisher;
  late Animation<double> _animationFisher;


  @override
  void initState() {
    super.initState();
    _animationControllerFisher =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationFisher = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationControllerFisher,
        curve: Curves.linear,
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationControllernRandom2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationnRandom2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationControllernRandom2,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllernRandom2.dispose();
    _animationControllerFisher.dispose();
    super.dispose();
  }

  void startAnimation() {
    _animationController.reset();
    _animationController.forward()
    .then((value) {
      setState(() {
        cargando = false;
        _animationController.reset();
      });
    });
  }

  void startAnimationnRandom2() {
    _animationControllernRandom2.reset();
    _animationControllernRandom2.forward()
    .then((value) {
      setState(() {
        cargandonRandom2 = false;
        _animationControllernRandom2.reset();
      });
    });
  }

  void startAnimationFisher() {
    _animationControllerFisher.reset();
    _animationControllerFisher.forward()
    .then((value) {
      setState(() {
        cargandonRandom3 = false;
        _animationControllerFisher.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Llamadas asincronicas')
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        cargando = true;
                        nRandom1 = '';
                      });

                      var datosApi = await MockApi().getFerrariInteger();

                      setState(() {
                        nRandom1 = datosApi.toString();
                      });

                      startAnimation();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.green,
                      padding: EdgeInsets.all(25.0),
                    ),
                    child: Icon(
                      Icons.flash_on,
                      color: Colors.black,
                      size: 36.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  if (cargando)
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          width: 200.0,
                          height: 20.0,
                          child: Stack(
                            children: [
                              Positioned(
                                left: (1.0 - _animation.value) * 100.0,
                                child: Container(
                                  width: _animation.value * 200.0,
                                  height: 10.0,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (!cargando && nRandom1.isNotEmpty)
                    Text(
                      nRandom1,
                      style: TextStyle(color: Colors.green, fontSize: 24),
                    ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  cargandonRandom2 = true;
                  nRandom2 = '';
                });

                var datosApi = await MockApi().getHyundaiInteger();

                setState(() {
                  nRandom2 = datosApi.toString();
                });

                startAnimationnRandom2();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: Colors.orange,
                padding: EdgeInsets.all(25.0),
              ),
              child: Icon(
                Icons.airport_shuttle,
                color: Colors.black,
                size: 36.0,
              ),
            ),
            SizedBox(height: 16.0),
            if (cargandonRandom2)
              AnimatedBuilder(
                animation: _animationnRandom2,
                builder: (context, child) {
                  return Container(
                    width: 200.0,
                    height: 10.0,
                    child: Stack(
                      children: [
                        Positioned(
                          left: (1.0 - _animationnRandom2.value) * 100.0,
                          child: Container(
                            width: _animationnRandom2.value * 200.0,
                            height: 10.0,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            if (!cargandonRandom2 && nRandom2.isNotEmpty)
              Text(
                nRandom2,
                style: TextStyle(color: Colors.orange, fontSize: 24),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  cargandonRandom3 = true;
                  nRandom3 = '';
                });

                var datosApi = await MockApi().getFisherPriceInteger();

                setState(() {
                  nRandom3 = datosApi.toString();
                });

                startAnimationFisher();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: Colors.red,
                padding: EdgeInsets.all(25.0),
              ),
              child: Icon(
                Icons.directions_walk,
                color: Colors.black,
                size: 36.0,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            AnimatedBuilder(
              animation: _animationFisher,
              builder: (context, child) {
                return Container(
                  width: 200.0,
                  height: 10.0,
                  child: Stack(
                    children: [
                      Positioned(
                        left: (1.0 - _animationFisher.value) * 100.0,
                        child: Container(
                          width: _animationFisher.value * 200.0,
                          height: 10.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            if (!cargandonRandom3 && nRandom3.isNotEmpty)
              Text(
                nRandom3,
                style: TextStyle(color: Colors.red, fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
