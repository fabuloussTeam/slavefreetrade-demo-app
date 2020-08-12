import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'package:webviewloadsite/features/presentation/components/navigation_controls.dart';

class MainPage extends StatefulWidget {

  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _title = "slavefreetrade";

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
      javascriptChannels: <JavascriptChannel>[
        _createTopBarJsChannel(),
      ].toSet(),
      onPageFinished: (url){ //Interact with javascript purpose to know the current pasge
        _showPageTitle();
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

  void _showPageTitle(){
    _controller.future.then((webViewController) {
      webViewController.evaluateJavascript('TopBarJsChannel.postMessage(document.title);');
    });
  }

  JavascriptChannel _createTopBarJsChannel(){
    return JavascriptChannel(
        name: "TopBarJsChannel",
        onMessageReceived: (message) {
          String newTitle = message.message;
          if(newTitle.contains('-')){
            newTitle = newTitle.substring(0, newTitle.indexOf("-")).trim();

            setState(() {
              _title = newTitle;
            });
          }
        }
    );
  }
}