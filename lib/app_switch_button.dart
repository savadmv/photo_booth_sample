import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final double width;
  final double height;

  final Color activeTextColor;

  final Color inactiveTextColor;

  const CustomSwitch(
      {Key key,
      this.value,
      this.onChanged,
      this.activeColor = Colors.white,
      this.inactiveColor = Colors.white,
      this.activeText = 'On',
      this.inactiveText = 'Off',
      this.activeTextColor = Colors.blue,
      this.inactiveTextColor = Colors.blue, this.width, this.height})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  Animation _circleAnimation1;
  AnimationController _animationController;
  bool isActive;

  @override
  void initState() {
    super.initState();

    setState(() {
      isActive = widget.value;
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
    _circleAnimation1 = AlignmentTween(
            end: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            begin: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
              setState(() {
                isActive=!isActive;
              });
            } else {
              _animationController.forward();
              setState(() {
                isActive=!isActive;
              });
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.height/2),
                color: _circleAnimation.value == Alignment.centerLeft
                    ? widget.inactiveColor
                    : widget.activeColor,
                border: Border.all(color: Colors.blue)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: <Widget>[
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: widget.height-2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: isActive?0:widget.height-10,right: isActive?widget.height-10:0),
                      child: Text(
                        isActive ? widget.activeText : widget.inactiveText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: widget.activeTextColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
