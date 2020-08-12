import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'package:webviewloadsite/features/presentation/components/navigation_controls.dart';

class ShopPage extends StatefulWidget {

   ShopPage({Key key}) : super(key: key);

  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _title = "Himdeve Shop";

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: <Widget>[
            NavigationControls(_controller.future),
          ],
        ),
        body: _buildWebView(),
    );
  }



  Widget _buildWebView(){
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: "https://slavefreetrade.org/",
      onWebViewCreated: (WebViewController webViewController){
        _controller.complete(webViewController);
      },
    );
  }

  Widget _buildChangeTitlebtn(){
    return FloatingActionButton(
      onPressed: (){
        setState((){
          _title = "promote human rights";
        });
      },
      child: Icon(Icons.title),
    );
  }
}