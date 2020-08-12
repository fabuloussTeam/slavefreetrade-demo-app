import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

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
        ),
        body: _buildWebView(),
        floatingActionButton: _buildShowUrlBtn(),
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

  Widget _buildShowUrlBtn(){
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
        if (controller.hasData){
          return FloatingActionButton(
            onPressed: () async {
              String url = await controller.data.currentUrl();
              print("current url is $url");
              print(controller.data.reload());
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Current url is: $url',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              );
            },
            child: Icon(Icons.link, size: 30.0,),
          );
        }
        return Container();
      },
    );
  }
}