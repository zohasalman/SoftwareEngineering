class RatedVendor{

  final String userId;
  final String vendorId;
  final String vendorName;
  final String vendorLogo;
  final double rating;
  final String reviewId;

  RatedVendor({this.userId, this.vendorId, this.vendorName, this.vendorLogo, this.rating, this.reviewId});

}

class RatedItem{
  final String userId;
  final String vendorId;
  final String itemId;
  final String itemName;
  final String itemLogo;
  final double rating;
  

  RatedItem({this.userId, this.vendorId, this.itemId, this.itemName, this.itemLogo, this.rating});
}