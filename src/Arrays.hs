module Arrays where

-- data Arr
-- data Val
-- data Ix

newarray :: Val -> Arr
newarray = undefined

index :: Ix -> Arr -> Val
index = undefined

update :: Ix -> Val -> Arr -> Arr
update = undefined


-- interpreter for an imperative language
data Id
data Term = Var Id | Con Int | Add Term Term
data Comm = Asgn Id Term | Seq Comm Comm | If Term Comm Comm
data Prog = Prog Comm Term

-- state of execution model -> array where indexes = identifier & values = integers
data Arr
type State = Arr
type Ix = Id
type Val = Int

-- interpreter for it
eval    :: Term -> State -> Int
eval (Var i) x = index i x
eval (Con a) x = a
eval (Add t u) x = eval t x + eval u x

exec    :: Comm -> State -> State
exec (Asgn i t) x = update i (eval t x) x
exec (Seq c d) x = exec d (exec c x)
exec (If t c d) x = if (eval t x) == 0 then exec c x else exec d x

elab  :: Prog -> Int
elab (Prog c t) =  eval t (exec c (newarray 0))

-- indicating explicitly that an array be single threaded with monads
type M a = State -> (a, State)

return    :: a -> M a  -- unit eq of return
return  a = \x -> (a, x)

(>>=)   :: M a -> (a -> M b) -> M b
m >>= k = \x -> let (a, y) = m x in
                 let (b, z) = k a y in
                   (b,z)

block :: Val -> M a -> a
block v m = let (a, x) = m (newarray v) in a 

fetch :: Ix -> M Val
fetch i = \x -> (index i x, x)

assign :: Ix -> Val -> M ()
assign i v = \x -> ((), update i v x)


