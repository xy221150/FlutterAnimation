import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
void main() => runApp(MaterialApp(home: MyApp(),));



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimationDemo")),
      body: Container(
        child: Column(
          children: <Widget>[
            MaterialButton(
              child: Text("缩放动画"),
              color: Colors.grey[500],
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context)=>Animations())));
              },
            ),
            MaterialButton(
              child: Text("旋转动画"),
              color: Colors.grey[500],
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context)=>CurvedAnimations())));
              },
            ),
            MaterialButton(
              child: Text("并行动画"),
              color: Colors.grey[500],
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: ((BuildContext context)=>OpacityAnimation())));
              },
            ),
          ],
        ),
      ),
    );
  }
}


class Animations extends StatefulWidget {
  @override
  _AnimationsState createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> with SingleTickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController=new AnimationController(duration: Duration(milliseconds: 3000),vsync: this);
    _animation=Tween(begin: 0.0,end: 300.0).animate(_animationController)
    ..addListener((){
      setState(() {
        print('${_animation.value}');
      });
    });
    _animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("缩放动画"),
      ),
      body: Center(
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height:_animation.value ,
          width: _animation.value,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}


class CurvedAnimations extends StatefulWidget {
  @override
  _CurvedAnimationsState createState() => _CurvedAnimationsState();
}

class _CurvedAnimationsState extends State<CurvedAnimations >with SingleTickerProviderStateMixin {

  CurvedAnimation _curvedAnimation;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController=new AnimationController(vsync: this,duration: Duration(milliseconds: 3000));
    _curvedAnimation=new CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("旋转动画"),
      ),
      body: Center(
        child: RotationTransition(
          turns: _curvedAnimation,
          child: FlutterLogo(size: 300),
        ),
      ),
    );
  }
}

class OpacityAnimation extends StatefulWidget {
  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation> with SingleTickerProviderStateMixin{
  Animation<double> _sizeAnimation;
  CurvedAnimation _curvedAnimation;
  AnimationController _animationController;
  Tween _opacityAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController=new AnimationController(vsync: this,duration: Duration(milliseconds: 3000));
    _curvedAnimation=new CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _sizeAnimation=new Tween(begin: 0.0,end: 300.0).animate(_animationController)
    ..addListener((){
      setState((){});
    });
    _opacityAnimation= Tween(begin: 0.0,end: 1.0);
    _curvedAnimation.addStatusListener((state){
      if(state == AnimationStatus.completed){
        _animationController.reverse();
      }else if(state == AnimationStatus.dismissed){
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("并行动画"),
      ),
      body: Center(
        child:Opacity(
          opacity: _opacityAnimation.evaluate(_curvedAnimation),
          child: Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height:_sizeAnimation.value ,
            width: _sizeAnimation.value,
            child: RotationTransition(
              turns: _curvedAnimation,
              child: FlutterLogo(),
            ),
          ),
        ),
      ),
    );
  }
}



