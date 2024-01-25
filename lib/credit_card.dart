import 'package:credit_card_design/colors.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  const CreditCard(
      {super.key,
      required this.height,
      required this.width,
      required this.color,
      required this.cardHolderName,
      required this.expireDateMonth,
      required this.expireDateYear,
      required this.cardCompany,
      required this.cvvNumber,
      required this.cardNumber});

  final double height;
  final double width;
  final Color color;
  final String cardHolderName;
  final String cardNumber;
  final int expireDateMonth;
  final int expireDateYear;
  final CardCompany cardCompany;
  final int cvvNumber;

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_isFrontVisible) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        _isFrontVisible = !_isFrontVisible;
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_isFrontVisible
                  ? _animation.value * 3.141
                  : (1 - _animation.value) * 3.141),
            alignment: Alignment.center,
            child: _isFrontVisible ? _frontPart() : _backPart(),
          );
        },
      ),
    );
  }

  Container _backPart() {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: widget.height / 1.5,
                width: widget.height / 1.5,
                decoration: BoxDecoration(
                    color: const Color(0xffc4c4c4).withOpacity(0.05),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.height / 1.5))),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: widget.height / 14,
                ),
                Container(
                  width: widget.width,
                  color: Colors.black,
                  height: widget.height / 5,
                ),
                SizedBox(
                  height: widget.height / 14,
                ),
                _cvvWidget(),
                SizedBox(
                  height: widget.height / 14,
                ),
                SizedBox(
                  width: widget.width * 0.87,
                  child: const Text(
                    """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas condimentum arcu ultrices diam viverra, blandit dignissim est aliquet. Duis at euismod est, id luctus justo. Maecenas dapibus ligula quis lectus egestas varius. Donec mattis ligula vitae mauris condimentum hendrerit. Quisque aliquet condimentum consectetur.""",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Container _frontPart() {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/chip.png", fit: BoxFit.fill, scale: 9),
                  SizedBox(
                    height: widget.height / 6,
                  ),
                  Text(
                      "**** **** **** ${widget.cardNumber.substring(widget.cardNumber.length - 4)}",
                      style: const TextStyle(
                          color: ColorTheme.white,
                          fontSize: 24,
                          letterSpacing: 6)),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _holderNameWidget(),
                      _expiryDateWidget(),
                      Image.asset(
                        widget.cardCompany.logo,
                        scale: 25,
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: widget.height / 1.5,
                width: widget.height / 1.5,
                decoration: BoxDecoration(
                    color: const Color(0xffc4c4c4).withOpacity(0.05),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.height / 1.5))),
              ),
            ),
          ],
        ));
  }

  Column _expiryDateWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expiry Date",
          style: TextStyle(color: Colors.white60, fontSize: 10),
        ),
        Text(
          "${widget.expireDateMonth}/${widget.expireDateYear}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Column _holderNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Card Holder Name",
          style: TextStyle(color: Colors.white60, fontSize: 10),
        ),
        Text(
          widget.cardHolderName,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Container _cvvWidget() {
    return Container(
      width: widget.width * 0.87,
      height: widget.height / 5,
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            widget.cvvNumber.toString(),
            style: const TextStyle(
                color: ColorTheme.black,
                fontSize: 18,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}

enum CardCompany { mastercard, troy }

extension CardGetter on CardCompany {
  String get logo {
    switch (this) {
      case CardCompany.mastercard:
        return "assets/mastercard_logo.png";
      case CardCompany.troy:
        return "assets/troy_logo.png";
    }
  }
}
