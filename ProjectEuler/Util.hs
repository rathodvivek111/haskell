module ProjectEuler.Util
( chunks
, chunksBy
, tuples
, sublists
, mergeInf
, merge
) where

-- chunks 3 [1..] == [ [1,2,3], [4,5,6], [7,8,9], ... ]
chunks _ [] = []
chunks k xs = let (front,back) = splitAt k xs
              in front:chunks k back

-- chunksBy generalizes chunks in that it allows a list of ks instead of a number
chunksBy _ [] = []
chunksBy (k:ks) xs = let (front,back) = splitAt k xs
                     in front:chunksBy ks back


-- tuples 2 [1,2,3] == [ [1,1], [1,2], [1,3], [2,1], [2,2], [2,3], [3,1], [3,2], [3,3] ]
tuples 0 _ = [[]] -- only the empty tuple
tuples k xs = [ x:t | t <- tuples (k-1) xs, x <- xs ]

-- similar to tuples, but maintains order
-- `sublists 2` will retrieve all distinct pairs from a list
sublists 0 _ = [[]]
sublists _ [] = []
sublists k (x:xs) = [ x:l | l <- sublists (k-1) xs ] ++ sublists k xs

mergeInf :: Ord a => [[a]] -> [a]
mergeInf = foldr merge2Sorted []
    where merge2Sorted (x:xs) ys = x:merge xs ys

merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x < y  = x:merge xs (y:ys)
                  | x == y = x:y:merge xs ys
                  | x > y  = y:merge (x:xs) ys
