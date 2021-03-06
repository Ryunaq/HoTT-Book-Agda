module Chapter5.Book where

open import Chapter4.Exercises public

---------------------------------------------------------------------------------

-- 5.1 Introduction to inductive types

-- Theorem 5.1.1
β-uniqueness : has-funext lzero πΎ β
               (E : β β π° πΎ)
               (f g : (x : β) β E x)
               (ez : E 0)
               (eβ : (n : β) β (E n) β (E (succ n)))
             β (f 0 β‘ ez) β (g 0 β‘ ez)
             β ((n : β) β f (succ n) β‘ eβ n (f n))
             β ((n : β) β g (succ n) β‘ eβ n (g n))
             β f β‘ g
β-uniqueness fe E f g ez eβ f0 g0 fs gs
  = funext fe fβΌg
    where
      fβΌg : f βΌ g
      fβΌg 0 = f0 β (g0 β»ΒΉ)
      fβΌg (succ n) = begin
        f (succ n) β‘β¨ fs n β©
        eβ n (f n) β‘β¨ ap (Ξ» - β eβ n -) (fβΌg n) β©
        eβ n (g n) β‘Λβ¨ gs n β©
        g (succ n) β

---------------------------------------------------------------------------------

-- 5.2 Uniqueness of inductive types

---------------------------------------------------------------------------------

-- 5.3 W-types

data π (A : π° πΎ) (B : A β π° πΏ) : π° (πΎ β πΏ) where
  sup : (x : A) (f : B x β π A B) β π A B

Nπ : π°β
Nπ = π π f
  where
    f : π β π°β
    f β = π
    f β = π

List : (A : π° πΎ) β π° πΎ
List A = π (π β A) f
  where
    f : π β A β π°β
    f (inl β) = π
    f (inr a) = π

0π 1π : Nπ
0π = sup β (Ξ» x β !π Nπ x)
1π = sup β (Ξ» x β 0π)

succπ : Nπ β Nπ
succπ n = sup β (Ξ» x β n)

π-induction : (A : π° πΎ) (B : A β π° πΏ) (E : π A B β π° π)
              (e : (a : A) (f : B a β π A B)
                   (g : (b : B a) β E (f b)) β E (sup a f))
            β ((w : π A B) β E w)
π-induction A B E e (sup x f) = e x f (Ξ» b β π-induction A B E e (f b))

doubleπ : Nπ β Nπ
doubleπ (sup β Ξ±) = 0π
doubleπ (sup β Ξ±) = succπ (succπ (Ξ± β))

doubleπ-1π : doubleπ 1π β‘ succπ (succπ 0π)
doubleπ-1π = refl (doubleπ 1π)

---------------------------------------------------------------------------------

-- 5.4 Inductive types are initial algebras

-- Definition 5.4.1
βAlg : (πΎ : Level) β π° (πΎ βΊ)
βAlg πΎ = Ξ£ C κ π° πΎ , C Γ (C β C)

-- Definition 5.4.2
βHom : (πΎ j : Level) (C : βAlg πΎ) (D : βAlg πΏ) β π° (πΎ β πΏ)
βHom πΎ πΏ (C , cβ , cβ) (D , dβ , dβ) =
  Ξ£ h κ (C β D) , (h cβ β‘ dβ) Γ ((c : C) β h (cβ c) β‘ dβ (h c))

-- Lemmas needed for 5.4.4

β-βHom : {πΎ πΏ π : Level}
         (C : βAlg πΎ)
         (D : βAlg πΏ)
         (E : βAlg π)
         (f : βHom πΎ πΏ C D) (g : βHom πΏ π D E)
       β βHom πΎ π C E
β-βHom (C , cβ , cβ) (D , dβ , dβ) (E , eβ , eβ)
  (f , fcβ , fc) (g , gdβ , gd) =
    (g β f , p , q)
  where
    p : g (f cβ) β‘ eβ
    p = g (f cβ) β‘β¨ ap g fcβ β©
        g dβ     β‘β¨ gdβ β©
        eβ       β
    q : (c : C) β g (f (cβ c)) β‘ eβ (g (f c))
    q c = g (f (cβ c)) β‘β¨ ap g (fc c) β©
          g (dβ (f c)) β‘β¨ gd (f c) β©
          eβ (g (f c)) β

id-βHom : {πΎ : Level}
          (C : βAlg πΎ)
        β βHom πΎ πΎ C C
id-βHom (C , cβ , cβ) =
  (id , refl cβ , Ξ» - β refl (cβ -))

-- Definition 5.4.3
isHinit-β : (πΎ : Level) (I : βAlg πΎ) β π° (πΎ βΊ)
isHinit-β πΎ I = (C : βAlg πΎ) β isContr (βHom πΎ πΎ I C)

d : (πΎ : Level) β βAlg πΎ β π° (πΎ βΊ)
d πΎ = isHinit-β πΎ

-- Theorem 5.4.4
isHinit-β-isProp : (πΎ : Level)
                 β (is-univalent πΎ)
                 β has-funext πΎ πΎ
                 β has-funext (πΎ βΊ) πΎ
                 β has-funext (πΎ βΊ) (πΎ βΊ)
                 β (I J : βAlg πΎ)
                 β (isHinit-β πΎ I) β (isHinit-β πΎ J)
                 β I β‘ J
isHinit-β-isProp πΎ u fe fe1 fe2 I@(cI , iβ , iβ) J@(cJ , jβ , jβ) fI gJ =
 pairβΌ (cIβ‘cJ , β‘-signature)
 where
  F : βHom πΎ πΎ I J
  F = prβ (fI J)
  G : βHom πΎ πΎ J I
  G = prβ (gJ I)
  f : cI β cJ
  f = prβ F
  g : cJ β cI
  g = prβ G

  gβfβ‘id : g β f β‘ id
  gβfβ‘id = ap prβ (endoI-isProp (β-βHom I J I F G) (id-βHom I))
   where
    endoI-isProp : isProp (βHom πΎ πΎ I I)
    endoI-isProp = prβ (contr-are-pointed-props (βHom πΎ πΎ I I) (fI I))

  fβgβ‘id : f β g β‘ id
  fβgβ‘id = ap prβ (endoJ-isProp (β-βHom J I J G F) (id-βHom J))
   where
    endoJ-isProp : isProp (βHom πΎ πΎ J J)
    endoJ-isProp = prβ (contr-are-pointed-props (βHom πΎ πΎ J J) (gJ J))

  cIβcJ : cI β cJ
  cIβcJ = (f , invs-are-equivs f q-qinv-f)
   where
    q-qinv-f : qinv f
    q-qinv-f = (g , happly fβgβ‘id , happly gβfβ‘id)

  cIβ‘cJ : cI β‘ cJ
  cIβ‘cJ = ua u cIβcJ

  β‘-signature : tr (Ξ» C β C Γ (C β C)) cIβ‘cJ (iβ , iβ) β‘ (jβ , jβ)
  β‘-signature = begin
    tr (Ξ» C β C Γ (C β C)) cIβ‘cJ (iβ , iβ) β‘β¨ trΓ β©
    (tr (Ξ» C β C) cIβ‘cJ iβ ,
      tr (Ξ» C β (C β C)) cIβ‘cJ iβ)         β‘β¨ pairΓβΌ (tr-iββ‘jβ ,
                                               funext fe tr-iβxβ‘jβx) β©
    (jβ , jβ) β
   where
    trΓ : tr (Ξ» C β C Γ (C β C)) cIβ‘cJ (iβ , iβ) β‘
          (tr (Ξ» C β C) cIβ‘cJ iβ , tr (Ξ» C β (C β C)) cIβ‘cJ iβ)
    trΓ = trAΓB (π° πΎ) (Ξ» C β C) (Ξ» C β C β C) cI cJ cIβ‘cJ (iβ , iβ)

    tr-iββ‘jβ : tr (Ξ» C β C) (cIβ‘cJ) iβ β‘ jβ
    tr-iββ‘jβ = begin
      tr (Ξ» C β C) (cIβ‘cJ) iβ β‘β¨ β‘u-comp u cIβcJ iβ β©
      f iβ                    β‘β¨ prβ (prβ F) β©
      jβ                      β

    tr-iβxβ‘jβx : tr (Ξ» C β (C β C)) (cIβ‘cJ) iβ βΌ jβ
    tr-iβxβ‘jβx x = begin
      tr (Ξ» C β (C β C)) cIβ‘cJ iβ x         β‘β¨ i β©
      tr id cIβ‘cJ (iβ (tr id (cIβ‘cJ β»ΒΉ) x)) β‘β¨ ii β©
      f (iβ (tr id (cIβ‘cJ β»ΒΉ) x))           β‘β¨ iii β©
      f (iβ (tr id (ua u (β-sym cIβcJ)) x)) β‘β¨ iv β©
      f (iβ (g x))                          β‘β¨ v β©
      jβ (f (g x))                          β‘β¨ vi β©
      jβ x                     β
     where
      i = happly (tr-f (π° πΎ) id id cI cJ cIβ‘cJ iβ) x
      ii = β‘u-comp u cIβcJ (iβ (tr id (cIβ‘cJ β»ΒΉ) x))
      iii = ap (Ξ» - β f (iβ (tr id - x))) (uaβ»ΒΉ fe u cIβcJ)
      iv = ap (Ξ» - β f (iβ -)) (β‘u-comp u (β-sym cIβcJ) x)
      v = prβ (prβ F) (g x)
      vi = ap jβ (happly fβgβ‘id x)
