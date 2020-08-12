import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final Future<WebViewController> _controllerFuture;

  const NavigationControls(this._controllerFuture, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controllerFuture,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
        if (controller.hasData){
          return Row(
            children: <Widget>[

              FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_left, color: Colors.white,),
                      Text("back", style: TextStyle(color: Colors.white, fontSize: 25),)
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
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: (){
                  controller.data.reload();
                },
              ),
              FlatButton(
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
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
