
module MonadsFpPaper where

data Term = Con Int | Div Term Term

eval :: Term -> Int
eval (Con a) = a
eval (Div t u) = (eval t) `div` (eval u)

answer, error   :: Term
answer  = (Div (Div (Con 1972) (Con 2)) (Con 23 ))
error   = (Div (Con 1) (Con 0))

-- Variation 1: Execeptions
data M a = Raise Exception | Return a
type Exception = String

eval'            :: Term -> M Int
eval' (Con a)    = Return a
eval' (Div t u)  = case eval' t of
                    Raise e -> Raise e
                    Return a ->
                      case eval' u of
                        Raise e -> Raise e
                        Return b ->
                          if b == 0
                             then Raise "Divide by zero"
                             else Return (a `div` b)


-- Variation 2: State
type M2 a = State -> (a, State)
type State = Int

eval2             :: Term -> M2 Int
eval2 (Con a) x   = (a, x)
eval2 (Div t u) x = let (a, y) = eval2 t x in
                      let (b, z) = eval2 u y in
                        (a `div` b, z + 1)

-- Variation 3: Output
type M3 a = (Output, a)
type Output = String

eval3 :: Term -> M3 Int
eval3  (Con a) = (line (Con a) a, a)
eval3 (Div t u)  = let (x, a)  = eval3 t in
                     let (y, b) = eval3 u in
                       (x ++ y ++ line (Div t u) (a `div` b), a `div` b)
line    :: Term -> Int -> Output
line t a   = "eval (" ++ showterm t ++ ") ⇐ " ++ showint a ++ "←"

showterm = undefined
showint = undefined


-- Monadic Variation 1: Exceptions
unit :: a -> M a
unit a = Return a

bind :: M a -> (a -> M b) -> M b
bind m k = case m of
            Raise e -> Raise e
            Return a -> k a
raise  :: Exception -> M a
raise e = Raise e


-- Monadic Variation 2: State
unit2 :: a -> M2 a
unit2 a = \x -> (a, x)

bind2 :: M2 a -> (a -> M2 b) -> M2 b
bind2 m k = \x -> let (a, y) = m x in
                let (b, z) = k a y in
                  (b, z)

-- tick :: M ()
-- tick = \x -> ((), x + 1)


