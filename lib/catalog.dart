import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/cart.dart';

import 'bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/item.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc =
        BlocProvider.of<CartBloc>(context); //-상위Main에서 cartBloc을 가져오기

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
        body:BlocBuilder(
            bloc: _cartBloc,
            builder: (BuildContext context, List state) {
              return ListView(
                children: _itemList
                    .map((item) => _buildItem(item, state, _cartBloc))
                    .toList(),
              );
            },
          ),
        );
  }

  Widget _buildItem(Item item, List state, CartBloc bloc) {
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
            setState(() {
              if (isChecked) {
                bloc.add(CartEvent(CartEventType.remove, item));
              } else {
                bloc.add(CartEvent(CartEventType.add, item));
              }
            });
          },
        ),
      ),
    );
  }
}
