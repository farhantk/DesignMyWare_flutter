// class UserModel {
//   int? id;
//   String? name;
//   String? email;
//   String? pesanan_id;
//   String? photo;
//   String? phone_number;
//   String? province;
//   String? city;
//   String? subdistrict;
//   String? ward;
//   String? street;
//   String? zip;
//   String? token;

//   UserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.pesanan_id,
//     this.photo,
//     this.phone_number,
//     this.province,
//     this.city,
//     this.subdistrict,
//     this.ward,
//     this.street,
//     this.zip,
//     this.token,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     var userData = json['data'];
//     return UserModel(
//       id: userData['id'],
//       email: userData['email'],
//       name: userData['name'],
//       pesanan_id: userData['pesanan_id'],
//       photo:userData['photo'],
//       phone_number:userData['phone_number'],
//       province:userData['province'],
//       city:userData['city'],
//       subdistrict:userData['subdistrict'],
//       ward:userData['ward'],
//       street:userData['street'],
//       zip:userData['zip'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'pesanan_id':pesanan_id,
//       'photo':photo,
//       'phone_number':phone_number,
//       'province':province,
//       'city':city,
//       'subdistrict':subdistrict,
//       'ward':ward,
//       'street':street,
//       'zip':zip,
//     };
//   }
//   @override
//   String toString() {
//     return 'User(id: $id, name: $name, email: $email, token: $token)';
//   }
// }