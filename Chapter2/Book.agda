module Chapter2.Book where

open import Chapter1.Book public
open import Chapter1.Exercises public

---------------------------------------------------------------------------------

-- Section 2.1 Types are higher groupoids

_â»Â¹ : {X : ð° ð¾} â {x y : X} â x â¡ y â y â¡ x
(refl x)â»Â¹ = refl x
infix  40 _â»Â¹

_â_ : {X : ð° ð¾} {x y z : X} â x â¡ y â y â¡ z â x â¡ z
(refl x) â (refl x) = (refl x)
infixl 30 _â_

-- Lemma 2.1.4 i)
refl-left : {X : ð° ð¾} {x y : X} {p : x â¡ y} â refl x â p â¡ p
refl-left {ð¤} {X} {x} {x} {refl x} = refl (refl x)

refl-right : {X : ð° ð¾} {x y : X} {p : x â¡ y} â p â refl y â¡ p
refl-right {ð¤} {X} {x} {y} {refl x} = refl (refl x)

-- Lemma 2.1.4 ii)
â»Â¹-leftâ : {X : ð° ð¾} {x y : X} (p : x â¡ y)
         â p â»Â¹ â p â¡ refl y
â»Â¹-leftâ (refl x) = refl (refl x)

â»Â¹-rightâ : {X : ð° ð¾} {x y : X} (p : x â¡ y)
          â p â p â»Â¹ â¡ refl x
â»Â¹-rightâ (refl x) = refl (refl x)

-- Lemma 2.1.4 iii)
â»Â¹-involutive : {X : ð° ð¾} {x y : X} (p : x â¡ y)
              â (p â»Â¹)â»Â¹ â¡ p
â»Â¹-involutive (refl x) = refl (refl x)

-- Lemma 2.1.4 iv)
â-assoc : {X : ð° ð¾} {x y z t : X} (p : x â¡ y) {q : y â¡ z} {r : z â¡ t}
        â (p â q) â r â¡ p â (q â r)
â-assoc (refl x) {refl x} {refl x} = refl (refl x)

-- Additional helper
â»Â¹-â : {X : ð° ð¾} {x y z : X} (p : x â¡ y) {q : y â¡ z}
     â (p â q)â»Â¹ â¡  (q)â»Â¹ â (p)â»Â¹
â»Â¹-â (refl x) {refl x} = refl (refl x)

-- Common â¡ reasoning helpers from
-- https://agda.github.io/agda-stdlib/Relation.Binary.PropositionalEquality.Core.html#2708

begin_ : {X : ð° ð¾} {x y : X} â x â¡ y â x â¡ y
begin_ xâ¡y = xâ¡y
infix  1 begin_

_â¡â¨â©_ : {X : ð° ð¾} (x {y} : X) â x â¡ y â x â¡ y
_ â¡â¨â© xâ¡y = xâ¡y

step-â¡ : {X : ð° ð¾} (x {y z} : X) â y â¡ z â x â¡ y â x â¡ z
step-â¡ _ yâ¡z xâ¡y = xâ¡y â yâ¡z
syntax step-â¡ x yâ¡z xâ¡y = x â¡â¨ xâ¡y â© yâ¡z

step-â¡Ë : {X : ð° ð¾} (x {y z} : X) â y â¡ z â y â¡ x â x â¡ z
step-â¡Ë _ yâ¡z yâ¡x = (yâ¡x)â»Â¹ â yâ¡z
syntax step-â¡Ë x yâ¡z yâ¡x = x â¡Ëâ¨ yâ¡x â© yâ¡z
infixr 2 _â¡â¨â©_ step-â¡ step-â¡Ë

_â : {X : ð° ð¾} (x : X) â x â¡ x
_â x = refl x
infix  3 _â

-- Definition 2.1.7.
ð°â : (ð¾ : Level) â ð° (ð¾ âº)
ð°â ð¾ = Î£ A ê (ð° ð¾) , A

-- Definition 2.1.8
Î© : ((A , a) : (ð°â ð¾)) â ð°â ð¾
Î© (A , a) = ((a â¡ a) , refl a)

Î©â¿ : (n : â) â ((A , a) : (ð°â ð¾)) â ð°â ð¾
Î©â¿ 0 (A , a) = (A , a)
Î©â¿ (succ n) (A , a) = Î©â¿ n (Î© (A , a))

---------------------------------------------------------------------------------

-- Section 2.2 Functions are functors

ap : {X : ð° ð¾} {Y : ð° ð¿} (f : X â Y) {x x' : X} â x â¡ x' â f x â¡ f x'
ap f {x} {x'} (refl x) = refl (f x)

-- Lemma 2.2.2 i)
ap-â : {X : ð° ð¾} {Y : ð° ð¿} (f : X â Y) {x y z : X}
       (p : x â¡ y) (q : y â¡ z)
     â ap f (p â q) â¡ ap f p â ap f q
ap-â f (refl x) (refl x) = refl (refl (f x))

-- Lemma 2.2.2 ii)
apâ»Â¹ : {X : ð° ð¾} {Y : ð° ð¿} (f : X â Y) {x y : X} (p : x â¡ y)
     â (ap f p)â»Â¹ â¡ ap f (p â»Â¹)
apâ»Â¹ f (refl x) = refl (refl (f x))

-- Lemma 2.2.2 iii)
ap-â : {X : ð° ð¾} {Y : ð° ð¿} {Z : ð° ð}
       (f : X â Y) (g : Y â Z) {x y : X} (p : x â¡ y)
     â ap (g â f) p â¡ (ap g â ap f) p
ap-â f g (refl x) = refl (refl (g (f x)))

-- Lemma 2.2.2 iv)
ap-id : {X : ð° ð¾} {x y : X} (p : x â¡ y)
      â ap id p â¡ p
ap-id (refl x) = refl (refl x)

-- Some more helpers
ap-const : {A : ð° ð¾} {B : ð° ð¿} {aâ aâ : A}
           (p : aâ â¡ aâ) (c : B)
         â ap (Î» _ â c) p â¡ refl c
ap-const (refl _) c = refl _

â-left-cancel : {X : ð° ð¾} {x y z : X}
                (p : x â¡ y) {q r : y â¡ z}
              â p â q â¡ p â r
              â q â¡ r
â-left-cancel p {q} {r} path = begin
  q              â¡Ëâ¨ refl-left â©
  refl _ â q     â¡Ëâ¨ ap (_â q) (â»Â¹-leftâ p) â©
  (p â»Â¹ â p) â q â¡â¨ â-assoc (p â»Â¹) â©
  p â»Â¹ â (p â q) â¡â¨ ap ((p â»Â¹) â_) path â©
  p â»Â¹ â (p â r) â¡Ëâ¨ â-assoc (p â»Â¹) â©
  (p â»Â¹ â p) â r â¡â¨ ap (_â r) (â»Â¹-leftâ p) â©
  refl _ â r     â¡â¨ refl-left â©
  r â

â-right-cancel : {X : ð° ð¾} {x y z : X}
                 (p : x â¡ y) {q : x â¡ y} {r : y â¡ z}
               â p â r â¡ q â r
               â p â¡ q
â-right-cancel p {q} {r} path = begin
  p              â¡Ëâ¨ refl-right â©
  p â refl _     â¡Ëâ¨ ap (p â_) (â»Â¹-rightâ r) â©
  p â (r â r â»Â¹) â¡Ëâ¨ â-assoc p â©
  (p â r) â r â»Â¹ â¡â¨ ap (_â (r â»Â¹)) path â©
  (q â r) â r â»Â¹ â¡â¨ â-assoc q â©
  q â (r â r â»Â¹) â¡â¨ ap (q â_) (â»Â¹-rightâ r) â©
  q â refl _     â¡â¨ refl-right â©
  q â

---------------------------------------------------------------------------------

-- Section 2.3 Type families are fibrations

-- Lemma 2.3.1.
tr : {A : ð° ð¾} (P : A â ð° ð¿) {x y : A}
          â x â¡ y â P x â P y
tr P (refl x) = id

-- Lemma 2.3.2.
lift : {A : ð° ð¾} {P : A â ð° ð¿}
       {x y : A} (u : P x) (p : x â¡ y)
     â ((x , u) â¡ (y , tr P p u))
lift u (refl x) = refl (x , u)

-- Lemma 2.3.4.
apd : {A : ð° ð¾} {P : A â ð° ð¿} (f : (x : A) â P x) {x y : A}
      (p : x â¡ y) â tr P p (f x) â¡ f y
apd f (refl x) = refl (f x)

-- Lemma 2.3.5.
trconst : {A : ð° ð¾} (B : ð° ð¿) {x y : A}
          (p : x â¡ y) (b : B)
        â tr (Î» - â B) p b â¡ b
trconst B (refl x) b = refl b

-- Lemma 2.3.8.
apd-trconst : {A : ð° ð¾} (B : ð° ð¿) {x y : A}
              (f : A â B)
              (p : x â¡ y)
            â apd f p â¡ trconst B p (f x) â ap f p
apd-trconst B f (refl x) = refl (refl (f x))

-- Lemma 2.3.9.
-- (Slight generalization for the ua-â proof)
tr-â : {A : ð° ð¾} (P : A â ð° ð¿) {x y z : A}
       (p : x â¡ y) (q : y â¡ z)
     â (tr P q) â (tr P p) â¡ tr P (p â q)
tr-â P (refl x) (refl x) = refl id

---------------------------------------------------------------------------------

-- Section 2.4 Homotopies and equivalences

_â¼_ : {X : ð° ð¾} {P : X â ð° ð¿} â Î  P â Î  P â ð° (ð¾ â ð¿)
f â¼ g = â x â f x â¡ g x

â¼-refl : {X : ð° ð¾} {P : X â ð° ð¿} (f : Î  P) â (f â¼ f)
â¼-refl f = Î» x â (refl (f x))

â¼-sym : {X : ð° ð¾} {P : X â ð° ð¿}
      â (f g : Î  P)
      â (f â¼ g)
      â (g â¼ f)
â¼-sym f g H = Î» x â (H x)â»Â¹

â¼-trans : {X : ð° ð¾} {P : X â ð° ð¿}
        â (f g h : Î  P)
        â (f â¼ g)
        â (g â¼ h)
        â (f â¼ h)
â¼-trans f g h H1 H2 = Î» x â (H1 x) â (H2 x)

-- Lemma 2.4.3.
â¼-naturality : {X : ð° ð¾} {A : ð° ð¿}
               (f g : X â A) (H : f â¼ g) {x y : X} {p : x â¡ y}
             â H x â ap g p â¡ ap f p â H y
â¼-naturality f g H {x} {_} {refl a} = refl-right â refl-left â»Â¹

-- Corollary 2.4.4.
~-id-naturality : {A : ð° ð¾}
                  (f : A â A) (H : f â¼ id) {x : A}
                â (H (f x)) â¡ (ap f (H x))
~-id-naturality f H {x} = begin
    H (f x)                             â¡Ëâ¨ refl-right â©
    H (f x) â (refl (f x))              â¡Ëâ¨ i â©
    H (f x) â (H x â (H x)â»Â¹)           â¡Ëâ¨ â-assoc (H (f x)) â©
    (H (f x) â H x) â (H x)â»Â¹           â¡Ëâ¨ ii â©
    (H (f x) â (ap id (H x))) â (H x)â»Â¹ â¡â¨ iii â©
    (ap f (H x) â (H x)) â (H x)â»Â¹      â¡â¨ â-assoc (ap f (H x)) â©
    ap f (H x) â ((H x) â (H x)â»Â¹)      â¡â¨ iv â©
    ap f (H x) â (refl (f x)) â¡â¨ refl-right â©
    ap f (H x) â
  where
    i = ap (H (f x) â_) (â»Â¹-rightâ (H x))
    ii = ap (Î» - â (H (f x) â (-)) â (H x)â»Â¹) (ap-id (H x))
    iii = ap (_â (H x)â»Â¹) (â¼-naturality f id H)
    iv = ap (ap f (H x) â_) (â»Â¹-rightâ (H x))


qinv : {A : ð° ð¾} {B : ð° ð¿} â (A â B) â ð° (ð¾ â ð¿)
qinv f = Î£ g ê (codomain f â domain f) , (f â g â¼ id) Ã (g â f â¼ id)

-- Example 2.4.7.
qinv-id-id : (A : ð° ð¾) â qinv (ðð A)
qinv-id-id A = (ðð A) , refl , refl

is-equiv : {A : ð° ð¾} {B : ð° ð¿} â (A â B) â ð° (ð¾ â ð¿)
is-equiv f = (Î£ g ê (codomain f â domain f) , (f â g â¼ id))
           Ã (Î£ h ê (codomain f â domain f) , (h â f â¼ id))

invs-are-equivs : {A : ð° ð¾} {B : ð° ð¿} (f : A â B)
                â (qinv f) â (is-equiv f)
invs-are-equivs f ( g , Î± , Î² ) = ( (g , Î±) , (g , Î²) )

equivs-are-invs : {A : ð° ð¾} {B : ð° ð¿} (f : A â B)
                â (is-equiv f) â (qinv f)
equivs-are-invs f ( (g , Î±) , (h , Î²) ) = ( g , Î± , Î²' )
  where
    Î³ : (x : codomain f) â (g x â¡ h x)
    Î³ x = begin
      g x â¡Ëâ¨ Î² (g x) â©
      h (f (g x)) â¡â¨ ap h (Î± x) â©
      h x â
    Î²' : g â f â¼ ðð (domain f)
    Î²' x = Î³ (f x) â Î² x

_â_ : ð° ð¾ â ð° ð¿ â ð° (ð¾ â ð¿)
A â B = Î£ f ê (A â B), is-equiv f

-- Helpers to get the quasi-inverse data from an equiv
â-â : {X : ð° ð¾} {Y : ð° ð¿} â X â Y â (X â Y)
â-â (f , eqv) = f

â-â : {X : ð° ð¾} {Y : ð° ð¿} â X â Y â (Y â X)
â-â (f , eqv) =
 let (g , Îµ , Î·) = equivs-are-invs f eqv
  in g

â-Îµ : {X : ð° ð¾} {Y : ð° ð¿}
    â (equiv : (X â Y))
    â ((prâ equiv) â (â-â equiv) â¼ id)
â-Îµ (f , eqv) =
 let (g , Îµ , Î·) = equivs-are-invs f eqv
  in Îµ

â-Î· : {X : ð° ð¾} {Y : ð° ð¿}
    â (equiv : (X â Y))
    â ((â-â equiv) â (prâ equiv) â¼ id)
â-Î· (f , eqv) =
 let (g , Îµ , Î·) = equivs-are-invs f eqv
  in Î·

-- Lemma 2.4.12. i)
â-refl : (X : ð° ð¾) â X â X
â-refl X = ( ðð X , invs-are-equivs (ðð X) (qinv-id-id X) )

-- Lemma 2.4.12. ii)
â-sym : {X : ð° ð¾} {Y : ð° ð¿} â X â Y â Y â X
â-sym ( f , e ) =
  let ( fâ»Â¹ , p , q) = ( equivs-are-invs f e )
  in  ( fâ»Â¹ , invs-are-equivs fâ»Â¹ (f , q , p) )

-- Lemma 2.4.12. iii)
â-trans-helper : {A : ð° ð¾} {B : ð° ð¿} {C : ð° ð}
                 (eqvf : A â B) (eqvg : B â C)
               â is-equiv (prâ eqvg â prâ eqvf)
â-trans-helper ( f , ef ) ( g , eg ) =
  let ( fâ»Â¹ , pf , qf ) = ( equivs-are-invs f ef )
      ( gâ»Â¹ , pg , qg ) = ( equivs-are-invs g eg )
      h1 : ((g â f) â (fâ»Â¹ â gâ»Â¹) â¼ id)
      h1 x = begin
        g (f (fâ»Â¹ (gâ»Â¹ x))) â¡â¨ ap g (pf (gâ»Â¹ x)) â©
        g (gâ»Â¹ x) â¡â¨ pg x â©
        x â
      h2 : ((fâ»Â¹ â gâ»Â¹) â (g â f) â¼ id)
      h2 x = begin
        fâ»Â¹ (gâ»Â¹ (g (f x))) â¡â¨ ap fâ»Â¹ (qg (f x)) â©
        fâ»Â¹ (f x) â¡â¨ qf x â©
        x â
  in  invs-are-equivs (g â f) ((fâ»Â¹ â gâ»Â¹) , h1 , h2)

â-trans : {A : ð° ð¾} {B : ð° ð¿} {C : ð° ð}
        â A â B â B â C â A â C
â-trans eqvf@( f , ef ) eqvg@( g , eg ) =
  let ( fâ»Â¹ , pf , qf ) = ( equivs-are-invs f ef )
      ( gâ»Â¹ , pg , qg ) = ( equivs-are-invs g eg )
      h1 : ((g â f) â (fâ»Â¹ â gâ»Â¹) â¼ id)
      h1 x = begin
        g (f (fâ»Â¹ (gâ»Â¹ x))) â¡â¨ ap g (pf (gâ»Â¹ x)) â©
        g (gâ»Â¹ x)           â¡â¨ pg x â©
        x â
      h2 : ((fâ»Â¹ â gâ»Â¹) â (g â f) â¼ id)
      h2 x = begin
        fâ»Â¹ (gâ»Â¹ (g (f x))) â¡â¨ ap fâ»Â¹ (qg (f x)) â©
        fâ»Â¹ (f x)           â¡â¨ qf x â©
        x â
  in  ((g â f) , â-trans-helper eqvf eqvg)

---------------------------------------------------------------------------------

-- 2.5 The higher groupoid structure of type formers

---------------------------------------------------------------------------------

-- 2.6 Cartesian product types

pairÃâ¼â»Â¹ : {X : ð° ð¾} {Y : ð° ð¿} {w w' : X Ã Y}
        â (w â¡ w') â ((prâ w â¡ prâ w') Ã (prâ w â¡ prâ w'))
pairÃâ¼â»Â¹ (refl w) = ( refl (prâ w) , refl (prâ w) )

pairÃâ¼ : {X : ð° ð¾} {Y : ð° ð¿} {w w' : X Ã Y}
        â ((prâ w â¡ prâ w') Ã (prâ w â¡ prâ w')) â (w â¡ w')
pairÃâ¼ {ð¾} {ð¿} {X} {Y} {w1 , w2} {w'1 , w'2} (refl w1 , refl w2) = refl (w1 , w2)

-- Theorem 2.6.2
Ã-â¡-â : {X : ð° ð¾} {Y : ð° ð¿} {w w' : X Ã Y}
      â (w â¡ w') â ((prâ w â¡ prâ w') Ã (prâ w â¡ prâ w'))
Ã-â¡-â {ð¾} {ð¿} {X} {Y} {w1 , w2} {w'1 , w'2} =
  pairÃâ¼â»Â¹ , invs-are-equivs pairÃâ¼â»Â¹ (pairÃâ¼ , Î± , Î²)
    where
      Î± : (pq : (w1 â¡ w'1) Ã (w2 â¡ w'2))
        â pairÃâ¼â»Â¹ (pairÃâ¼ pq) â¡ pq
      Î± (refl w1 , refl w2) = refl (refl w1 , refl w2)
      Î² : (p : (w1 , w2 â¡ w'1 , w'2))
        â pairÃâ¼ (pairÃâ¼â»Â¹ p) â¡ p
      Î² (refl (w1 , w2)) = refl (refl (w1 , w2))

Ã-uniq : {X : ð° ð¾} {Y : ð° ð¿} {z : X Ã Y}
       â z â¡ (prâ z , prâ z)
Ã-uniq {ð¾} {ð¿} {X} {Y} {z} = pairÃâ¼ (refl (prâ z) , refl (prâ z))

trAÃB : (Z : ð° ð¾) (A : Z â ð° ð¿) (B : Z â ð° ð)
        (z w : Z) (p : z â¡ w) (x : A z Ã B z)
      â tr (Î» - â A - Ã B -) p x â¡ (tr A p (prâ x) , tr B p (prâ x))
trAÃB Z A B z w (refl z) x = Ã-uniq

---------------------------------------------------------------------------------

-- 2.7 Î£-types

-- Theorem 2.7.2.
pairâ¼â»Â¹ : {X : ð° ð¾} {Y : X â ð° ð¿} {w w' : Î£ Y}
        â (w â¡ w') â (Î£ p ê (prâ w â¡ prâ w') , tr Y p (prâ w) â¡ (prâ w'))
pairâ¼â»Â¹ (refl w) = ( refl (prâ w) , refl (prâ w) )

pairâ¼ : {X : ð° ð¾} {Y : X â ð° ð¿} {w w' : Î£ Y}
        â (Î£ p ê (prâ w â¡ prâ w') , tr Y p (prâ w) â¡ (prâ w')) â (w â¡ w')
pairâ¼ {ð¾} {ð¿} {X} {Y} {w1 , w2} {w'1 , w'2} (refl w1 , refl w2) = refl (w1 , w2)

Î£-â¡-â : {X : ð° ð¾} {Y : X â ð° ð¿} {w w' : Î£ Y}
      â (w â¡ w') â (Î£ p ê (prâ w â¡ prâ w') , tr Y p (prâ w) â¡ (prâ w'))
Î£-â¡-â {ð¾} {ð¿} {X} {Y} {w1 , w2} {w'1 , w'2} =
  pairâ¼â»Â¹ , invs-are-equivs pairâ¼â»Â¹ (pairâ¼ , Î± , Î²)
    where
      Î± : (pq : (Î£ p ê w1 â¡ w'1 , tr Y p w2 â¡ w'2))
        â pairâ¼â»Â¹ (pairâ¼ pq) â¡ pq
      Î± (refl w1 , refl w2) = refl (refl w1 , refl w2)
      Î² : (p : (w1 , w2 â¡ w'1 , w'2))
        â pairâ¼ (pairâ¼â»Â¹ p) â¡ p
      Î² (refl (w1 , w2)) = refl (refl (w1 , w2))

-- Corollary 2.7.3.
Î£-uniq : {X : ð° ð¾} {P : X â ð° ð¿} (z : Î£ P)
       â z â¡ (prâ z , prâ z)
Î£-uniq z = pairâ¼ (refl _ , refl _)

---------------------------------------------------------------------------------

-- 2.8 The unit type

ð-â¡-â : (x y : ð) â (x â¡ y) â ð
ð-â¡-â â â = f , invs-are-equivs f (g , Î± , Î²)
  where
    f : â â¡ â â ð
    f p = â
    g : ð â â â¡ â
    g â = refl â
    Î± : (p : ð) â f (g p) â¡ p
    Î± â = refl â
    Î² : (p : â â¡ â) â g (f p) â¡ p
    Î² (refl â) = refl (refl â)

ð-isProp : (x y : ð) â (x â¡ y)
ð-isProp x y =
  let (f , ((g , f-g) , (h , h-f))) = ð-â¡-â x y
   in h â

---------------------------------------------------------------------------------

-- 2.9 Î -types and the function extensionality axiom

happly : {A : ð° ð¾} {B : A â ð° ð¿} {f g : Î  B}
       â f â¡ g â f â¼ g
happly p x = ap (Î» - â - x) p

has-funext : (ð¾ ð¿ : Level) â ð° ((ð¾ â ð¿)âº)
has-funext ð¾ ð¿ = {A : ð° ð¾} {B : A â ð° ð¿} (f g : Î  B)
               â is-equiv (happly {ð¾} {ð¿} {A} {B} {f} {g})

qinv-fe : has-funext ð¾ ð¿ â {A : ð° ð¾} {B : A â ð° ð¿}
          (f g : Î  B) â qinv happly
qinv-fe fe f g = equivs-are-invs happly (fe f g)

funext : {A : ð° ð¾} {B : A â ð° ð¿}
       â has-funext ð¾ ð¿ â {f g : Î  B}
       â f â¼ g â f â¡ g
funext fe {f} {g} htpy =
  let (funext , Î· , Îµ ) = qinv-fe fe f g
   in funext htpy

-- Slightly generalized
â¡fe-comp : {A : ð° ð¾} {B : A â ð° ð¿}
         â (fe : has-funext ð¾ ð¿) â {f g : Î  B}
         â (h : f â¼ g)
         â happly (funext fe h) â¡ h
â¡fe-comp fe {f} {g} h =
  let (funext , Î· , Îµ ) = qinv-fe fe f g
   in Î· h

â¡fe-uniq : {A : ð° ð¾} {B : A â ð° ð¿}
         â (fe : has-funext ð¾ ð¿) â {f g : Î  B}
         â (p : f â¡ g)
         â p â¡ funext fe (happly p)
â¡fe-uniq fe {f} {g} p =
  let (funext , Î· , Îµ ) = qinv-fe fe f g
   in (Îµ p)â»Â¹

tr-f : (X : ð° ð¾) (A : X â ð° ð¿) (B : X â ð° ð)
      (xâ xâ : X) (p : xâ â¡ xâ) (f : A xâ â B xâ)
    â tr (Î» x â (A x â B x)) p f â¡ (Î» x â tr B p (f (tr A (p â»Â¹) x)))
tr-f X A B xâ xâ (refl xâ) f = refl f

---------------------------------------------------------------------------------

-- 2.10 Universes and the univalence axiom

-- I need this helper to delay the pattern match in `idtoeqv`, while
-- still being able to use this same function in other places, like in
-- the construction of `ua-â`.
idtoeqv-helper : {X Y : ð° ð¾} (p : X â¡ Y) â is-equiv (tr (Î» C â C) p)
idtoeqv-helper (refl X) = invs-are-equivs (ðð X) (qinv-id-id X)

idtoeqv : {X Y : ð° ð¾} â X â¡ Y â X â Y
idtoeqv {ð¾} {X} {Y} p = tr (Î» C â C) p , (idtoeqv-helper p)

is-univalent : (ð¾ : Level) â ð° (ð¾ âº)
is-univalent ð¾ = (X Y : ð° ð¾) â is-equiv (idtoeqv {ð¾} {X} {Y})

qinv-ua : is-univalent ð¾ â (X Y : ð° ð¾) â qinv idtoeqv
qinv-ua ua X Y = equivs-are-invs idtoeqv (ua X Y)

ua : is-univalent ð¾ â {X Y : ð° ð¾} â X â Y â X â¡ Y
ua u {X} {Y} eqv =
  let (ua , idtoeqvâua , uaâidtoeqv) = qinv-ua u X Y
   in ua eqv

-- Helper
idâ¼idtoeqvâua : (u : is-univalent ð¾)
              â {X Y : ð° ð¾} (eqv : X â Y)
              â eqv â¡ idtoeqv (ua u eqv)
idâ¼idtoeqvâua u {X} {Y} eqv =
  let (ua , idtoeqvâua , uaâidtoeqv) = qinv-ua u X Y
   in (idtoeqvâua eqv)â»Â¹

â¡u-comp : (u : is-univalent ð¾)
        â {X Y : ð° ð¾} (eqv : X â Y) (x : X)
        â tr (Î» C â C) (ua u eqv) x â¡ prâ eqv x
â¡u-comp u {X} {Y} eqv x =
 happly q x
  where
   p : idtoeqv (ua u eqv) â¡ eqv
   p = (idâ¼idtoeqvâua u eqv)â»Â¹
   q : tr (Î» C â C) (ua u eqv) â¡ prâ eqv
   q = ap prâ p

â¡u-uniq : (u : is-univalent ð¾)
        â {X Y : ð° ð¾} (p : X â¡ Y)
        â p â¡ ua u (idtoeqv p)
â¡u-uniq u {X} {Y} p =
  let (ua , idtoeqvâua , uaâidtoeqv) = qinv-ua u X Y
   in (uaâidtoeqv p)â»Â¹

ua-id : (u : is-univalent ð¾)
      â {A : ð° ð¾}
      â refl A â¡ ua u (â-refl A)
ua-id u {A} = begin
  refl A                  â¡â¨ â¡u-uniq u (refl A) â©
  ua u (idtoeqv (refl A)) â¡â¨â©
  ua u (â-refl A)         â

ua-â : (u : is-univalent ð¾)
     â {X Y Z : ð° ð¾} (eqvf : X â Y) (eqvg : Y â Z)
     â ua u eqvf â ua u eqvg â¡ ua u (â-trans eqvf eqvg)
ua-â u {X} {Y} {Z} eqvf eqvg = proof â»Â¹
 where
  p = ua u eqvf
  q = ua u eqvg

  idtoeqv-â : â-trans (idtoeqv p) (idtoeqv q) â¡ idtoeqv (p â q)
  idtoeqv-â = begin
     â-trans (idtoeqv p) (idtoeqv q)                 â¡â¨â©
     â-trans (tr (Î» C â C) p , idtoeqv-helper p)
       (tr (Î» C â C) q , idtoeqv-helper q)           â¡â¨â©
     ((tr (Î» C â C) q) â (tr (Î» C â C) p) ,
       â-trans-helper (idtoeqv p) (idtoeqv q))       â¡â¨ pairâ¼((tr-â id p q) ,
                                                          refl _) â©
     (tr (Î» C â C) (p â q) ,
       tr (Î» - â is-equiv -) (tr-â id p q)
         (â-trans-helper (idtoeqv p) (idtoeqv q)) )  â¡â¨ pairâ¼(refl _ ,
                                                        lemma p q) â©
     (tr (Î» C â C) (p â q) , idtoeqv-helper (p â q)) â¡â¨â©
     idtoeqv (p â q) â
    where
     lemma : (p : X â¡ Y) (q : Y â¡ Z)
           â tr is-equiv (tr-â id p q)
              (â-trans-helper (idtoeqv p) (idtoeqv q))
             â¡ idtoeqv-helper (p â q)
     lemma (refl X) (refl X) = refl _

  proof : ua u (â-trans eqvf eqvg) â¡ ua u eqvf â ua u eqvg
  proof = begin
   ua u (â-trans eqvf eqvg)               â¡â¨ ap (Î» - â ua u (â-trans - eqvg))
                                               (idâ¼idtoeqvâua u eqvf)         â©
   ua u (â-trans (idtoeqv p) eqvg)        â¡â¨ ap (Î» - â ua u
                                                (â-trans (idtoeqv p) -))
                                               (idâ¼idtoeqvâua u eqvg)         â©
   ua u (â-trans (idtoeqv p) (idtoeqv q)) â¡â¨ ap (Î» - â ua u -) idtoeqv-â      â©
   ua u (idtoeqv (p â q))                 â¡Ëâ¨ â¡u-uniq u (p â q)               â©
   ua u eqvf â ua u eqvg                  â

-- Lemma for next theorem
tr-_â¼id : (fe : has-funext ð¾ ð¾)
        â {X : ð° ð¾} {f : X â X}
        â (h : f â¼ id)
        â tr (_â¼ id) (funext fe h) h â¡ refl
tr-_â¼id fe {X} {f} h = begin
  tr (_â¼ id) (funext fe h) h                      â¡â¨ i â©
  tr (_â¼ id) (funext fe (happly (funext fe h))) h â¡â¨ ii â©
  tr (_â¼ id) (funext fe (happly (funext fe h)))
      (happly (funext fe h))                      â¡â¨ iii (funext fe h) â©
  refl â
 where
  i = ap (Î» - â tr (_â¼ id) (funext fe -) h) (â¡fe-comp fe h)â»Â¹
  ii = ap (Î» - â tr (_â¼ id) (funext fe (happly (funext fe h))) -)
           (â¡fe-comp fe h)â»Â¹
  iii : (p : f â¡ id) â tr (_â¼ id) (funext fe (happly p)) (happly p) â¡ refl
  iii (refl f) = ap (Î» - â tr (_â¼ id) - (happly (refl f)))
                     (â¡fe-uniq fe (refl f))â»Â¹

uaâ»Â¹ : has-funext ð¾ ð¾
     â (u : is-univalent ð¾)
     â {X Y : ð° ð¾} (eqv : X â Y)
     â (ua u eqv)â»Â¹ â¡ ua u (â-sym eqv)
uaâ»Â¹ fe u {X} {Y} eqvf@(f , e) =
  sufficient (ua-â u eqvfâ»Â¹ eqvf â claim2)
 where
  p = ua u eqvf
  eqvfâ»Â¹ = â-sym eqvf
  fâ»Â¹ = prâ eqvfâ»Â¹
  q = ua u eqvfâ»Â¹

  sufficient : (ua u eqvfâ»Â¹ â ua u eqvf â¡ refl Y)
             â (ua u eqvf)â»Â¹ â¡ ua u eqvfâ»Â¹
  sufficient p = begin
   (ua u eqvf)â»Â¹                             â¡Ëâ¨ refl-left â©
   refl Y â (ua u eqvf)â»Â¹                    â¡â¨ ap (_â (ua u eqvf)â»Â¹) (p â»Â¹) â©
   (ua u eqvfâ»Â¹ â ua u eqvf) â (ua u eqvf)â»Â¹ â¡â¨ â-assoc (ua u eqvfâ»Â¹)        â©
   ua u eqvfâ»Â¹ â (ua u eqvf â (ua u eqvf)â»Â¹) â¡â¨ ap (ua u eqvfâ»Â¹ â_)
                                                 (â»Â¹-rightâ (ua u eqvf))     â©
   ua u eqvfâ»Â¹ â refl X                      â¡â¨ refl-right                   â©
   ua u eqvfâ»Â¹                               â

  claim1 : â-trans eqvfâ»Â¹ eqvf â¡ â-refl Y
  claim1 = pairâ¼ (i , ii)
   where
    i : (f â fâ»Â¹) â¡ id
    i = funext fe (â-Î· eqvfâ»Â¹)
    id-equiv : is-equiv id
    id-equiv = tr is-equiv i (â-trans-helper eqvfâ»Â¹ (f , e))
    g h : Y â Y
    g = prâ (prâ id-equiv)
    h = prâ (prâ id-equiv)
    Î± = prâ (prâ id-equiv)
    Î² = prâ (prâ id-equiv)

    ii : ((g , Î±) , (h , Î²)) â¡ ((id , refl) , (id , refl))
    ii = pairÃâ¼(pairâ¼(iia , iib) , pairâ¼(iic , iid))
     where
      iia : g â¡ id
      iia = funext fe Î±
      iib : tr (_â¼ id) iia Î± â¡ refl
      iib = tr-_â¼id fe Î±
      iic : h â¡ id
      iic = funext fe Î²
      iid : tr (_â¼ id) iic Î² â¡ refl
      iid = tr-_â¼id fe Î²

  claim2 : ua u (â-trans eqvfâ»Â¹ eqvf) â¡ refl Y
  claim2 = ap (ua u) claim1 â ((â¡u-uniq u (refl Y))â»Â¹)

-- Note: Univalence could be expressed like this
Univalence : ð¤Ï
Univalence = â i â is-univalent i

---------------------------------------------------------------------------------

-- 2.11 Identity type

-- Lemma 2.11.2.
trHomc- : {A : ð° ð¾} (a : A) {xâ xâ : A} (p : xâ â¡ xâ) (q : a â¡ xâ)
          â tr (Î» x â a â¡ x) p q â¡ q â p
trHomc- a (refl _) (refl _) = refl-right â»Â¹

trHom-c : {A : ð° ð¾} (a : A) {xâ xâ : A} (p : xâ â¡ xâ) (q : xâ â¡ a)
          â tr (Î» x â x â¡ a) p q â¡ p â»Â¹ â q
trHom-c a (refl _) (refl _) = refl-right â»Â¹

trHomâ : {A : ð° ð¾} {xâ xâ : A} (p : xâ â¡ xâ) (q : xâ â¡ xâ)
          â tr (Î» x â x â¡ x) p q â¡ p â»Â¹ â q â p
trHomâ (refl _) q = (ap (_â refl _) refl-left â refl-right) â»Â¹

-- Theorem 2.11.3.
tr-fxâ¡gx : {A : ð° ð¾} {B : ð° ð¿} (f g : A â B) {a a' : A}
           (p : a â¡ a') (q : f a â¡ g a)
         â tr (Î» x â f x â¡ g x) p q â¡ (ap f p)â»Â¹ â q â (ap g p)
tr-fxâ¡gx f g (refl a) q = (refl-left)â»Â¹ â (refl-right)â»Â¹

-- Theorem 2.11.5.
tr-xâ¡x-â : {A : ð° ð¾} {a a' : A}
           (p : a â¡ a') (q : a â¡ a) (r : a' â¡ a')
         â (tr (Î» x â x â¡ x) p q â¡ r) â (q â p â¡ p â r)
tr-xâ¡x-â {ð¾} {A} {a} {a'} (refl a) q r =
  map , invs-are-equivs map (mapâ»Â¹ , Îµ , Î·)
 where
  map : q â¡ r â (q â refl a â¡ refl a â r)
  map eq = refl-right â eq â (refl-left)â»Â¹
  mapâ»Â¹ : (q â refl a â¡ refl a â r) â (q â¡ r)
  mapâ»Â¹ eq' = (refl-right)â»Â¹ â eq' â refl-left
  Îµ : map â mapâ»Â¹ â¼ id
  Îµ eq' = begin
    refl-right â ((refl-right)â»Â¹ â eq' â refl-left) â (refl-left)â»Â¹ â¡Ëâ¨ i â©
    refl-right â ((refl-right)â»Â¹ â eq') â refl-left â (refl-left)â»Â¹ â¡Ëâ¨ ii â©
    refl-right â (refl-right)â»Â¹ â eq' â refl-left â (refl-left)â»Â¹   â¡â¨ iii â©
    refl _ â eq' â refl-left â (refl-left)â»Â¹                        â¡â¨ iv â©
    eq' â refl-left â (refl-left)â»Â¹                                 â¡â¨ v â©
    eq' â (refl-left â (refl-left)â»Â¹)                               â¡â¨ vi â©
    eq' â refl _                                                    â¡â¨ vii â©
    eq' â
   where
    i   = ap (_â (refl-left)â»Â¹) (â-assoc refl-right)
    ii  = ap (Î» - â - â refl-left â (refl-left)â»Â¹) (â-assoc refl-right)
    iii = ap (Î» - â - â eq' â refl-left â (refl-left)â»Â¹) (â»Â¹-rightâ refl-right)
    iv  = ap (Î» - â - â refl-left â (refl-left)â»Â¹) refl-left
    v   = â-assoc eq'
    vi  = ap (eq' â_) (â»Â¹-rightâ refl-left)
    vii = refl-right
  Î· : mapâ»Â¹ â map â¼ id
  Î· eq = begin
    (refl-right)â»Â¹ â (refl-right â eq â (refl-left)â»Â¹) â refl-left â¡Ëâ¨ i â©
    (refl-right)â»Â¹ â (refl-right â eq) â (refl-left)â»Â¹ â refl-left â¡Ëâ¨ ii â©
    (refl-right)â»Â¹ â refl-right â eq â (refl-left)â»Â¹ â refl-left   â¡â¨ iii â©
    refl _ â eq â (refl-left)â»Â¹ â refl-left                        â¡â¨ iv â©
    eq â (refl-left)â»Â¹ â refl-left                                 â¡â¨ v â©
    eq â ((refl-left)â»Â¹ â refl-left)                               â¡â¨ vi â©
    eq â refl _                                                    â¡â¨ vii â©
    eq â
   where
    i   = ap (_â refl-left) (â-assoc ((refl-right)â»Â¹))
    ii  = ap (Î» - â - â (refl-left)â»Â¹ â refl-left) (â-assoc ((refl-right)â»Â¹))
    iii = ap (Î» - â - â eq â (refl-left)â»Â¹ â refl-left) (â»Â¹-leftâ refl-right)
    iv  = ap (Î» - â - â (refl-left)â»Â¹ â refl-left) refl-left
    v   = â-assoc eq
    vi  = ap (eq â_) (â»Â¹-leftâ refl-left)
    vii = refl-right


---------------------------------------------------------------------------------

-- 2.12 Coproducts

ð-is-not-ð : ð â¢ ð
ð-is-not-ð p = tr id p â

â-is-not-â : â â¢ â
â-is-not-â p = ð-is-not-ð q
 where
  f : ð â ð° lzero
  f â = ð
  f â = ð
  q : ð â¡ ð
  q = ap f p

---------------------------------------------------------------------------------

-- 2.15 Universal properties

-- Theorem 2.15.7.
Î Î£-comm : {X : ð° ð¾} {A : X â ð° ð¿} {P : (x : X) â A x â ð° ð}
        â has-funext ð¾ (ð¿ â ð)
        â ((x : X) â Î£ a ê (A x) , P x a)
           â (Î£ g ê ((x : X) â A x) , ((x : X) â P x (g x)))
Î Î£-comm {ð¾} {ð¿} {ð} {X} {A} {P} fe = map , invs-are-equivs map (mapâ»Â¹ , Îµ , Î·)
  where
    map : ((x : X) â Î£ a ê (A x) , P x a)
        â (Î£ g ê ((x : X) â A x) , ((x : X) â P x (g x)))
    map f = (Î» x â prâ (f x)) , (Î» x â prâ (f x))
    mapâ»Â¹ : (Î£ g ê ((x : X) â A x) , ((x : X) â P x (g x)))
          â ((x : X) â Î£ a ê (A x) , P x a)
    mapâ»Â¹ (g , h) = Î» x â (g x , h x)
    Îµ : map â mapâ»Â¹ â¼ id
    Îµ (g , h) = refl _
    Î· : mapâ»Â¹ â map â¼ id
    Î· f = funext fe (Î» x â (Î£-uniq (f x))â»Â¹)
