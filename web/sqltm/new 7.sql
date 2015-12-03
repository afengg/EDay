SELECT P.ExpireDate, P.PostDate, P.CustomerID, P.AuctionID, A.CurrentHiBid, I.Name, A.CurrentHiBidder
FROM  Post P, Auction A, Item I, Person PE, Sale S
WHERE P.ExpireDate > NOW() AND P.AuctionID = A.AuctionID AND P.CustomerID = PE.SSN AND I.ItemID = A.ItemID AND P.AuctionID NOT IN (Select AuctionID From Post);
