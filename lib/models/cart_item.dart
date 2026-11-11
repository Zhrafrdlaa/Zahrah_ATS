import 'customization.dart';
import 'product.dart';

class CartItem {
  CartItem({
    required this.product,
    this.size = SizeOption.regular,
    this.sweetness = Sweetness.normal,
    this.ice = IceLevel.normal,
    this.note = '',
    this.quantity = 1,
  });

  final Product product;
  final SizeOption size;
  final Sweetness sweetness;
  final IceLevel ice;
  final String note;
  int quantity;

  /// Dua item dianggap sama jika produk & kustomisasinya identik.
  String get key =>
      '${product.id}|${size.name}|${sweetness.name}|${ice.name}|$note';

  int get unitPrice => product.basePrice + (product.isDrink ? size.extraPrice : 0);
  int get total => unitPrice * quantity;

  String get summary => product.isDrink
      ? '${size.label} • ${sweetness.label} • ${ice.label}'
      : 'Original';

  CartItem copy() => CartItem(
        product: product,
        size: size,
        sweetness: sweetness,
        ice: ice,
        note: note,
        quantity: quantity,
      );
}
