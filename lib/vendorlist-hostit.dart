import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vendor.dart';
import 'userRedirection.dart';
import 'hostit.dart';

class VendorsListHostit extends StatefulWidget {
  @override
  _VendorsListStateHostIt createState() => _VendorsListStateHostIt();
}

class _VendorsListStateHostIt extends State<VendorsListHostit> {
  @override
  Widget build(BuildContext context) {

    final vendors = Provider.of<List<Vendor>>(context);
    if (vendors == null){
      return LoadingScreen();
    }else{
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          return Card(
            child:ListTile(
                      onTap: () {
                        debugPrint('${vendors[index].name} is pressed!');
                      },
                  
                      title: Text(vendors[index].name),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${vendors[index].logo}'),
                      ),
                      //trailing: Text('${vendors[index].aggregateRating}'),
                    )
            );
        });
    }
  }
}