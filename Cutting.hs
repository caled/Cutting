--cutFast is quick but best result not guaranteed
--cutSlow is too slow for more than around 10 items and uses too much memory
--  (needs improving)
--
--Example
--cutFast sheetsize kurf [cuts]
--ie
--	cutFast 210 10 [150, 100, 20, 5, 170, 180, 100, 50, 30, 195])
--  -> [[195,5],[180,20],[170,30],[150,50],[100,100]]
--

module Cutting 
(cutSlow, cutFast)
 where
import Data.List
import Data.Ord
import GHC.Exts

cutSlow :: Integer -> Integer -> [Integer] -> [[Integer]]
cutSlow sheetsize kurf cuts = best
	where
		cuts2 = filter (<sheetsize) cuts
		cuts3 = map (\x -> (head x, length x)) (group $ sort cuts2)
		cuts4 = map (head cuts2:) (unqPermutations $ tail cuts2)
		cuts5 = map (cut_in_order sheetsize kurf) cuts4
		best = minimumBy (\x -> comparing length(x)) cuts5		

unqPermutations :: Eq a => [a] -> [[a]]
unqPermutations [] = [[]]
unqPermutations xs = [ x:ps | x <- nub xs, ps <- unqPermutations (delete x xs) ]

cut' :: Integer -> Integer -> [Integer] -> [(Integer, Int)] -> Integer
cut' _ _ [] [] = 0
cut' sheetsize kurf leftovers cuts = 1

cut_in_order _ _ [] = []
cut_in_order sheetsize kurf cuts = cuts_on_sheet : cut_in_order sheetsize kurf cuts_leftover
	where
		(cuts_on_sheet, cuts_leftover) = last $ takeWhile (\(x,_) -> sum(intersperse kurf x) <= sheetsize) $ zip (inits cuts) (tails cuts) 

cutFast sheetsize kurf cuts = cut_greedy' sheetsize sheetsize kurf (sortWith (\x->(-x)) cuts)
cut_greedy' _ _ _ []  = [[]]
cut_greedy' sheetsize leftovers kurf cuts  = rest
	where 
		nextcuts = filter (<=leftovers) cuts
		(rest) = 
			if nextcuts == [] then 
				[] : cut_greedy' sheetsize sheetsize kurf cuts
			else
				let					
					nextcut = head nextcuts
					otherCuts = delete nextcut cuts
					(f:sol) = cut_greedy' sheetsize (leftovers-nextcut-kurf) kurf otherCuts
				in
					(nextcut:f):sol
					--[otherCuts]
