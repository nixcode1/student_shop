import 'package:flutter/material.dart';

class Sliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(Icons.arrow_back),
            backgroundColor: Colors.orangeAccent,
            expandedHeight: MediaQuery.of(context).size.height / 2,
            // floating: true,
            // pinned: true,
            // snap: true,
            stretch: true,
            flexibleSpace: const FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text('Available seats'),
              stretchModes: [StretchMode.fadeTitle],
            ),
            actions: [Icon(Icons.shopping_cart)],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: Icon(Icons.volume_off),
                  title: Text("Volume Off"),
                ),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_mute),
                    title: Text("Volume Mute")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
                ListTile(
                    leading: Icon(Icons.volume_down),
                    title: Text("Volume Down")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
