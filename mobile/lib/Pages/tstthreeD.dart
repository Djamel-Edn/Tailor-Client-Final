import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:o3d/o3d.dart';
// import 'package:o3d/o3d.dart';

class tstthreed extends StatefulWidget {
  const tstthreed({super.key});

  @override
  State<tstthreed> createState() => _tstthreedState();
}

final advancecontroller = AdvancedDrawerController();
void DrawerController() {
  advancecontroller.showDrawer();
}

class _tstthreedState extends State<tstthreed> with TickerProviderStateMixin {
  //Create controller object to control 3D model.

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        disabledGestures: true,
        controller: advancecontroller,
        openScale: 0.8,
        openRatio: 0.6,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.abc),
              onPressed: () {
                DrawerController();
              },
            ),
          ),
          body: Center(
              child: Container(
                  child: //The 3D viewer widget
                      Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: O3D.asset(
                  src: "images/glbglbttled.glb",
                  autoPlay: true,
                  autoRotate: true,
                  ar: true,
                  xrEnvironment: true,
                  autoRotateDelay: 1,
                  disableZoom: true,
                  environmentImage: "",
                ),

                // child: WebView(
                //   initialUrl:
                //       "https://app.vectary.com/p/3YQlapkqjcKZs9wGxKDn14",
                //   javascriptMode: JavascriptMode.unrestricted,
                // )
              )
            ],
          ))),
        ),
        backdropColor: Colors.blueGrey,
        drawer: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  advancecontroller.hideDrawer();
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                )),
            Expanded(
              child: Container(),
            )
          ],
        )));
  }
}
