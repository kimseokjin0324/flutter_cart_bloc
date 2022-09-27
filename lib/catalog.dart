import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/cart.dart';
import 'package:flutter_cart_bloc/main.dart';

import 'bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/item.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Catalog'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cart()));
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: cartBloc.cartList,
          builder: (context, snapshot) {
            return ListView(
              children: cartBloc.itemList
                  .map((item) => _buildItem(item, snapshot.data))
                  .toList(),
            );
          },
        ));
  }

  Widget _buildItem(
    Item item,
    List<Item> state,
  ) {
    final isChecked = state.contains(item); //-state는 내가 선택한 리스트

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(fontSize: 31.0),
        ),
        subtitle: Text('${item.price}'),
        trailing: IconButton(
          icon: isChecked
              ? Icon(Icons.check, color: Colors.red)
              : Icon(Icons.check),
          onPressed: () {
            if (isChecked) {
              cartBloc.add(CartEvent(CartEventType.remove, item));
            } else {
              cartBloc.add(CartEvent(CartEventType.add, item));
            }
          },
        ),
      ),
    );
  }
}
