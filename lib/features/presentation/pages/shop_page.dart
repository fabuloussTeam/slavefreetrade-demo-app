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
  final globalKey = GlobalKey<ScaffoldState>(); // Used to access to Scaffold when we are outside

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
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
      onWebViewCreated: (WebViewController webViewController){ // Used for access to controller.data
        _controller.complete(webViewController);
      },
      navigationDelegate: (request){ //Manage request from url
        return _buildNavigationDecision(request);
      },
    );
  }

  // Function to manage a request from url: Exemple of 'donate' link
  NavigationDecision _buildNavigationDecision(NavigationRequest request){
    if(request.url.contains('donate')){
     globalKey.currentState.showSnackBar(
         SnackBar(
           content: Text(
             "You do not have the rigths to access of this",
             style: TextStyle(fontSize: 20),
           ),
         )
     );

      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }
}