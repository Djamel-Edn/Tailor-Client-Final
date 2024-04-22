class Order {
  String client, tailor, status;
  DateTime orderDate;
  double totalPrice;
  Order(
      {required this.client,
      required this.orderDate,
      required this.status,
      required this.totalPrice,
      required this.tailor});
}
