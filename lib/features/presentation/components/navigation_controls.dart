import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final Future<WebViewController> _controllerFuture;
  final String url = "https://slavefreetrade.org/";

  const NavigationControls(this._controllerFuture, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controllerFuture,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
        if (controller.hasData){
          return Row(
            children: <Widget>[
              _buildBackAtHomebtn(controller, context),
              _buildBackHistoryBtn(controller, context),
              _buildRefreshBtn(controller, context),
              _buildForwardBtn(controller, context)
            ],
          );
        }
        return Container();
      },
    );
  }


  //Build Back at Home
  IconButton _buildBackAtHomebtn(AsyncSnapshot<WebViewController> controller, context){
    return IconButton(
      icon: Icon(Icons.home, color: Colors.white,),
      onPressed: () async{
         if(await controller.hasData){
           controller.data.loadUrl(url);
         }
      },
    );
  }

  // Button Back History
  FlatButton _buildBackHistoryBtn(AsyncSnapshot<WebViewController> controller, context){
    return  FlatButton(
      textColor: Colors.white,
      child: Row(
        children: <Widget>[
          Icon(Icons.arrow_left, color: Colors.white),
          Text("back", style: TextStyle(fontSize: 25),)
        ],
      ),
      onPressed: () async{
        if(await controller.data.canGoBack()){
          controller.data.goBack();
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'No back History'
                ),
              )
          );
        }
      },
    );
  }

  // Button Refresh
  IconButton _buildRefreshBtn(AsyncSnapshot<WebViewController> controller, context){
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: (){
        controller.data.reload();
      },
    );
  }

  // Button Forward History
  FlatButton _buildForwardBtn(AsyncSnapshot<WebViewController> controller, context){
      return  FlatButton(
        child: Row(
          children: <Widget>[
            Text("next", style: TextStyle(color: Colors.white, fontSize: 25)),
            Icon(Icons.arrow_right, color: Colors.white,),
          ],
        ),
        onPressed: () async{
          if(await controller.data.canGoForward()){
            controller.data.goForward();
          } else {
            Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'No forward History'
                  ),
                )
            );
          }
        },
      );
  }



}

class _buildWebView {
}
