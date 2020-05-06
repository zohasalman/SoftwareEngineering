import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'userRedirection.dart';           
            
class ReviewFromDB extends StatefulWidget {
  @override
  _ReviewFromDBState createState() => _ReviewFromDBState();
}

class _ReviewFromDBState extends State<ReviewFromDB> {
  @override
  Widget build(BuildContext context) {
    final reviews = Provider.of<List<Review>>(context);
    if (reviews == null){
      return LoadingScreen();
    }else{
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 30.0, left: 15.0),
                          child: GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30.0,
                                child: Image.asset('asset/image/circular.png'),
                              ))),
                    ],
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 10.0),
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 200.0,
                          maxWidth: 200.0,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: Text( reviews[index].review,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              );
        }
      );
    }
  }
}
            
            
            
            
            
            
            