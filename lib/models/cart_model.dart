class Cart {
  final int id;
  final int jumlah_pesanan;
  final int harga_barang;
  final int pesanan_id;
  final int status;
  final int status_nego;

  const Cart({
    required this.id,
    required this.jumlah_pesanan,
    required this.harga_barang,
    required this.pesanan_id,
    required this.status,
    required this.status_nego,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      jumlah_pesanan: json['jumlah_pesanan'],
      harga_barang: json['harga_barang'],
      pesanan_id: json['pesanan_id'],
      status: json['status'],
      status_nego: json['status_nego'],
    );
  }
}
