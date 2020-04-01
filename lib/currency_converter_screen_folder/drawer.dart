import 'dart:io';

import 'package:currencyconverter/const_files/const_data.dart';
import 'package:flutter/material.dart';
import 'package:currencyconverter/themes_data/my_themes.dart';
import 'package:currencyconverter/themes_data/custom_theme.dart';
import 'package:url_launcher/url_launcher.dart';

var currentTheme;

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool closeButtonPressed = false;

  _launchURL(buttonUrl) async {
    var url = buttonUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  Widget _selectColorButton(text, theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: kDynamicItemsSize(ctx: context, value: 70),
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          onPressed: () {
            currentTheme = theme;
            _changeTheme(context, theme);
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: kDynamicItemsSize(ctx: context, value: 7)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerInfoText({String text, FontWeight fontWeight, bool heading}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: kDynamicItemsSize(ctx: context, value: 8),
            color: heading ? currentTheme == MyThemeKeys.DARK ? Colors.white : kMainPurple : currentTheme == MyThemeKeys.DARK ? Colors.grey.shade400 : Colors.grey.shade600,
            fontWeight: fontWeight),
      ),
    );
  }

  Widget _lineDivider() {
    return Padding(
      padding: EdgeInsets.only(
          left: kDynamicItemsSize(ctx: context, value: 30),
          right: kDynamicItemsSize(ctx: context, value: 30)),
      child: Divider(
        color: Colors.grey.shade400,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFE0CEFD),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      'assets/images/icon.png',
                      width: kDynamicItemsSize(ctx: context, value: 35),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Currency Converter',
                      style: TextStyle(
                          color: kMainPurple,
                          fontSize: kDynamicItemsSize(ctx: context, value: 10),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _selectColorButton("Light Theme", MyThemeKeys.LIGHT),
                    _selectColorButton("Dark Theme", MyThemeKeys.DARK),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _drawerInfoText(text: 'Thank you for:',fontWeight: FontWeight.bold, heading: true),

                    _lineDivider(),
                    _drawerInfoText(text: 'exchange rates API', fontWeight: FontWeight.bold, heading: false),
                    _drawerInfoText(text:
                    'https://exchangeratesapi.io', fontWeight: FontWeight.normal, heading: false),
                    _lineDivider(),
                    _drawerInfoText(text: 'amazing icons set', fontWeight: FontWeight.bold, heading: false),
                    _drawerInfoText(text: 'https://fontawesome.com', fontWeight: FontWeight.normal, heading: false),
                    FlatButton(
                      child: Text(
                        'link to the license',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      onPressed: () {
                        print('work');
                        _launchURL('https://fontawesome.com/license/free');
                      },
                    ),
                    _lineDivider(),
                    _drawerInfoText(text: 'url_launcher package', fontWeight: FontWeight.bold, heading: false),
                    _drawerInfoText(text: 'flutter.dev', fontWeight: FontWeight.normal, heading: false),
                    _lineDivider(),
                    _drawerInfoText(text: 'App version 1.0', fontWeight:FontWeight.bold, heading: false),
                    _drawerInfoText(text: 'Last update 28/03/2020', fontWeight: FontWeight.bold, heading: false),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  closeButtonPressed = true;
                  Future.delayed(Duration(milliseconds: 250), () {
                    setState(() {
                      closeButtonPressed = false;
                    });
                  });
                });
                exit(0);
              },
              child: Container(
                color: closeButtonPressed ? kPressedButton : kLightPurple,
                height: kDynamicItemsSize(ctx: context, value: 22),
                child: Icon(
                  Icons.power_settings_new,
                  color: closeButtonPressed ? kLightPurple : kUnpressedButton,
                  size: kDynamicItemsSize(ctx: context, value: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
