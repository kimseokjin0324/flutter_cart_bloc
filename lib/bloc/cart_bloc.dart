import 'package:bloc/bloc.dart';
import 'package:flutter_cart_bloc/item.dart';

enum CartEventType { add, remove }

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc extends Bloc<CartEvent, List<Item>> {
  CartBloc() : super([]); //- 초기값 세팅

  // async* stream형태의 방출하는것을 만들것이다 라는듯
  // yield async* 을 통해서 만들어진 Stream을 밀어줄것이다 라는 뜻
  @override
  Stream<List<Item>> mapEventToState(CartEvent event) async* {
    switch (event.type) {
      case CartEventType.add:
        state.add(event.item);
        break;
      case CartEventType.remove:
        state.remove(event.item);
        break;
    }
    yield state;
  }
}
