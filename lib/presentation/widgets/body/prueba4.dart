/*abstract class CartState {}

class CartInitialState extends CartState {}

class CartEmptyState extends CartState {}

class CartWithDataState extends CartState {
  final List<Product> products;

  CartWithDataState(this.products);
}

class CartProcessingState extends CartState {
  final List<Product> products;
  final String shippingAddress;

  CartProcessingState(this.products, this.shippingAddress);
}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState(this.errorMessage);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitialState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartEvent) {
      yield CartEmptyState();

      try {
        final products = await cartRepository.getProducts();
        yield CartWithDataState(products);
      } catch (error) {
        yield CartErrorState('Failed to load cart data.');
      }
    } else if (event is ProcessCartEvent) {
      final currentState = state;

      if (currentState is CartWithDataState) {
        yield CartProcessingState(currentState.products, event.shippingAddress);

        try {
          await cartRepository.processCart(
              currentState.products, event.shippingAddress);
          yield CartEmptyState();
        } catch (error) {
          yield CartErrorState('Failed to process cart.');
        }
      }
    }
  }
}

class CartPage extends StatelessWidget {
  final CartBloc cartBloc;

  CartPage(this.cartBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartInitialState) {
          // Mostrar el widget de inicio.
        } else if (state is CartEmptyState) {
          // Mostrar un mensaje de carrito vacío.
        } else if (state is CartWithDataState) {
          // Mostrar la lista de productos en el carrito.
          final products = state.products;
        } else if (state is CartProcessingState) {
          // Mostrar una pantalla de procesamiento con los productos y dirección de envío.
          final products = state.products;
          final shippingAddress = state.shippingAddress;
        } else if (state is CartErrorState) {
          // Mostrar un mensaje de error.
          final errorMessage = state.errorMessage;
        }
      },
    );
  }
}*/
