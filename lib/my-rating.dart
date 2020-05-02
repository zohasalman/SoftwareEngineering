class RatedVendor{

  final String userId;
  final String vendorId;
  final String vendorName;
  final String vendorLogo;
  final double rating;
  final String reviewId;

  RatedVendor({this.userId, this.vendorId, this.vendorName, this.vendorLogo, this.rating, this.reviewId});

  Map<String, dynamic> toJSON(){
    return{
      'userId' : userId, 
      'vendorId' : vendorId,
      'vendorName' : vendorName,
      'vendorLogo' : vendorLogo,
      'myVendorRating' : rating,
      'vendorReviewId' : reviewId,
    };
  }

}

class RatedItem{
  final String userId;
  final String vendorId;
  final String itemId;
  final String itemName;
  final String itemLogo;
  final double rating;
  

  RatedItem({this.userId, this.vendorId, this.itemId, this.itemName, this.itemLogo, this.rating});

  Map<String, dynamic> toJSON(){
    return{
      'userId' : userId, 
      'vendorId' : vendorId,
       'itemId' : itemId,
      'itemName' : itemName,
      'itemLogo' : itemLogo,
      'myItemRating' : rating,
    };
  }
}

class Review{
  final String userId;
  final String vendorId;
  final String reviewId;
  final String review;

  Review({this.userId, this.vendorId, this.reviewId, this.review});
  
  Map<String, dynamic> toJSON(){
    return{
      'userId' : userId, 
      'vendorId' : vendorId,
      'reviewId':'',
      'review': review,
    };
  }

}