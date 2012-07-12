module Main 
 where
import Cutting

main :: IO ()
main = do
    --putStrLn (show $ cut 210 5 [100, 45, 100, 100, 50])
	--putStrLn (show $ cut 210 5 [100, 45, 100, 100, 50, 75, 75, 10, 30, 40, 50, 60, 5, 6, 7, 8, 10])
	putStrLn (show $ cutFast 210 10 [150,100,50])
	putStrLn (show $ cutFast 210 10 [150, 100, 20, 5, 170, 180, 100, 50, 30, 195])
	putStrLn (show $ cutFast 210 10 [100, 170, 180, 100, 50, 30, 195])
	putStrLn (show $ cutFast 210 10 [150, 100, 20, 5, 170, 180, 100, 50, 30, 195])
	--putStrLn (show $ cut 210 10 [150, 100, 20, 5, 170, 180, 100, 50, 30, 195])
    --putStrLn (show $ cut_in_order 210 10 [100, 100, 100, 50, 75, 75])
    --putStrLn $ show $ sort [1,2,3]

