
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pensamentos/model/Quote.dart';

class TransitionQuote extends StatefulWidget {

  final Quote quote;

  TransitionQuote(this.quote);

  @override
  _TransitionQuoteState createState() => _TransitionQuoteState();
}

class _TransitionQuoteState extends State<TransitionQuote> with SingleTickerProviderStateMixin {


  AnimationController _controller;
  Animation<double> _animationOpacity;
  Animation<double> _animationTranslate;


  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animationTranslate = Tween(begin: 100.0, end: 0.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
    if (_controller.isCompleted) {
      _controller.reset();
      _controller.forward();
    }
    return _buildInformation(widget.quote);
  }

  Widget _buildInformation(Quote quote) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Opacity(
          opacity: _animationOpacity.value,
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 750/666,
                child: Image.asset(quote.image, fit: BoxFit.contain,),
              ),
              _message(quote)
            ],
          ),
        );
      },
    );
  }

  Transform _message(Quote quote) {
    return Transform.translate(
              offset: Offset(0.0, _animationTranslate.value),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AutoSizeText(
                      quote.quote,
                      maxLines: 5,
                      style: GoogleFonts.dancingScript(fontSize: 30),textAlign: TextAlign.center, textScaleFactor: 1,),
                  ),
                  Text(quote.author, style: GoogleFonts.dancingScript(fontSize: 40, fontWeight: FontWeight.bold))
                ],
              ),
            );
  }
}
