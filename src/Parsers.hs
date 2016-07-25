
module Parsers where

import Prelude hiding ((>>=), return)


-- list monad
return :: a -> [a]
return a = [a]

(>>=) :: [a] -> (a -> [b]) -> [b]
[] >>= k = []
(a:x) >>= k = k a ++ (x >>= k)

-- Parser
type M a = State -> [(a, State)]
type State = String

data Term = Con Int | Div Term Term



--

guarantee :: M a -> M a
guarantee m x = let u = m x in (fst (head u), snd (head u)) : tail u

