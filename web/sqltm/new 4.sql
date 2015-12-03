SELECT CustomerID AS SellerID,
Copies_Sold as CopiesSold, ItemID, Monitor, CurrentHiBidder as BuyerID, CurrentHiBid as SalePrice
FROM Post P, Auction A
WHERE P.AuctionID = ? AND A.AuctionID = ?