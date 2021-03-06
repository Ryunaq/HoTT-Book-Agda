module Chapter2.Book where

open import Chapter1.Book public
open import Chapter1.Exercises public

---------------------------------------------------------------------------------

-- Section 2.1 Types are higher groupoids

_⁻¹ : {X : 𝒰 𝒾} → {x y : X} → x ≡ y → y ≡ x
(refl x)⁻¹ = refl x
infix  40 _⁻¹

_∙_ : {X : 𝒰 𝒾} {x y z : X} → x ≡ y → y ≡ z → x ≡ z
(refl x) ∙ (refl x) = (refl x)
infixl 30 _∙_

-- Lemma 2.1.4 i)
refl-left : {X : 𝒰 𝒾} {x y : X} {p : x ≡ y} → refl x ∙ p ≡ p
refl-left {𝓤} {X} {x} {x} {refl x} = refl (refl x)

refl-right : {X : 𝒰 𝒾} {x y : X} {p : x ≡ y} → p ∙ refl y ≡ p
refl-right {𝓤} {X} {x} {y} {refl x} = refl (refl x)

-- Lemma 2.1.4 ii)
⁻¹-left∙ : {X : 𝒰 𝒾} {x y : X} (p : x ≡ y)
         → p ⁻¹ ∙ p ≡ refl y
⁻¹-left∙ (refl x) = refl (refl x)

⁻¹-right∙ : {X : 𝒰 𝒾} {x y : X} (p : x ≡ y)
          → p ∙ p ⁻¹ ≡ refl x
⁻¹-right∙ (refl x) = refl (refl x)

-- Lemma 2.1.4 iii)
⁻¹-involutive : {X : 𝒰 𝒾} {x y : X} (p : x ≡ y)
              → (p ⁻¹)⁻¹ ≡ p
⁻¹-involutive (refl x) = refl (refl x)

-- Lemma 2.1.4 iv)
∙-assoc : {X : 𝒰 𝒾} {x y z t : X} (p : x ≡ y) {q : y ≡ z} {r : z ≡ t}
        → (p ∙ q) ∙ r ≡ p ∙ (q ∙ r)
∙-assoc (refl x) {refl x} {refl x} = refl (refl x)

-- Additional helper
⁻¹-∙ : {X : 𝒰 𝒾} {x y z : X} (p : x ≡ y) {q : y ≡ z}
     → (p ∙ q)⁻¹ ≡  (q)⁻¹ ∙ (p)⁻¹
⁻¹-∙ (refl x) {refl x} = refl (refl x)

-- Common ≡ reasoning helpers from
-- https://agda.github.io/agda-stdlib/Relation.Binary.PropositionalEquality.Core.html#2708

begin_ : {X : 𝒰 𝒾} {x y : X} → x ≡ y → x ≡ y
begin_ x≡y = x≡y
infix  1 begin_

_≡⟨⟩_ : {X : 𝒰 𝒾} (x {y} : X) → x ≡ y → x ≡ y
_ ≡⟨⟩ x≡y = x≡y

step-≡ : {X : 𝒰 𝒾} (x {y z} : X) → y ≡ z → x ≡ y → x ≡ z
step-≡ _ y≡z x≡y = x≡y ∙ y≡z
syntax step-≡ x y≡z x≡y = x ≡⟨ x≡y ⟩ y≡z

step-≡˘ : {X : 𝒰 𝒾} (x {y z} : X) → y ≡ z → y ≡ x → x ≡ z
step-≡˘ _ y≡z y≡x = (y≡x)⁻¹ ∙ y≡z
syntax step-≡˘ x y≡z y≡x = x ≡˘⟨ y≡x ⟩ y≡z
infixr 2 _≡⟨⟩_ step-≡ step-≡˘

_∎ : {X : 𝒰 𝒾} (x : X) → x ≡ x
_∎ x = refl x
infix  3 _∎

-- Definition 2.1.7.
𝒰∙ : (𝒾 : Level) → 𝒰 (𝒾 ⁺)
𝒰∙ 𝒾 = Σ A ꞉ (𝒰 𝒾) , A

-- Definition 2.1.8
Ω : ((A , a) : (𝒰∙ 𝒾)) → 𝒰∙ 𝒾
Ω (A , a) = ((a ≡ a) , refl a)

Ωⁿ : (n : ℕ) → ((A , a) : (𝒰∙ 𝒾)) → 𝒰∙ 𝒾
Ωⁿ 0 (A , a) = (A , a)
Ωⁿ (succ n) (A , a) = Ωⁿ n (Ω (A , a))

---------------------------------------------------------------------------------

-- Section 2.2 Functions are functors

ap : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} (f : X → Y) {x x' : X} → x ≡ x' → f x ≡ f x'
ap f {x} {x'} (refl x) = refl (f x)

-- Lemma 2.2.2 i)
ap-∙ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} (f : X → Y) {x y z : X}
       (p : x ≡ y) (q : y ≡ z)
     → ap f (p ∙ q) ≡ ap f p ∙ ap f q
ap-∙ f (refl x) (refl x) = refl (refl (f x))

-- Lemma 2.2.2 ii)
ap⁻¹ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} (f : X → Y) {x y : X} (p : x ≡ y)
     → (ap f p)⁻¹ ≡ ap f (p ⁻¹)
ap⁻¹ f (refl x) = refl (refl (f x))

-- Lemma 2.2.2 iii)
ap-∘ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} {Z : 𝒰 𝓀}
       (f : X → Y) (g : Y → Z) {x y : X} (p : x ≡ y)
     → ap (g ∘ f) p ≡ (ap g ∘ ap f) p
ap-∘ f g (refl x) = refl (refl (g (f x)))

-- Lemma 2.2.2 iv)
ap-id : {X : 𝒰 𝒾} {x y : X} (p : x ≡ y)
      → ap id p ≡ p
ap-id (refl x) = refl (refl x)

-- Some more helpers
ap-const : {A : 𝒰 𝒾} {B : 𝒰 𝒿} {a₁ a₂ : A}
           (p : a₁ ≡ a₂) (c : B)
         → ap (λ _ → c) p ≡ refl c
ap-const (refl _) c = refl _

∙-left-cancel : {X : 𝒰 𝒾} {x y z : X}
                (p : x ≡ y) {q r : y ≡ z}
              → p ∙ q ≡ p ∙ r
              → q ≡ r
∙-left-cancel p {q} {r} path = begin
  q              ≡˘⟨ refl-left ⟩
  refl _ ∙ q     ≡˘⟨ ap (_∙ q) (⁻¹-left∙ p) ⟩
  (p ⁻¹ ∙ p) ∙ q ≡⟨ ∙-assoc (p ⁻¹) ⟩
  p ⁻¹ ∙ (p ∙ q) ≡⟨ ap ((p ⁻¹) ∙_) path ⟩
  p ⁻¹ ∙ (p ∙ r) ≡˘⟨ ∙-assoc (p ⁻¹) ⟩
  (p ⁻¹ ∙ p) ∙ r ≡⟨ ap (_∙ r) (⁻¹-left∙ p) ⟩
  refl _ ∙ r     ≡⟨ refl-left ⟩
  r ∎

∙-right-cancel : {X : 𝒰 𝒾} {x y z : X}
                 (p : x ≡ y) {q : x ≡ y} {r : y ≡ z}
               → p ∙ r ≡ q ∙ r
               → p ≡ q
∙-right-cancel p {q} {r} path = begin
  p              ≡˘⟨ refl-right ⟩
  p ∙ refl _     ≡˘⟨ ap (p ∙_) (⁻¹-right∙ r) ⟩
  p ∙ (r ∙ r ⁻¹) ≡˘⟨ ∙-assoc p ⟩
  (p ∙ r) ∙ r ⁻¹ ≡⟨ ap (_∙ (r ⁻¹)) path ⟩
  (q ∙ r) ∙ r ⁻¹ ≡⟨ ∙-assoc q ⟩
  q ∙ (r ∙ r ⁻¹) ≡⟨ ap (q ∙_) (⁻¹-right∙ r) ⟩
  q ∙ refl _     ≡⟨ refl-right ⟩
  q ∎

---------------------------------------------------------------------------------

-- Section 2.3 Type families are fibrations

-- Lemma 2.3.1.
tr : {A : 𝒰 𝒾} (P : A → 𝒰 𝒿) {x y : A}
          → x ≡ y → P x → P y
tr P (refl x) = id

-- Lemma 2.3.2.
lift : {A : 𝒰 𝒾} {P : A → 𝒰 𝒿}
       {x y : A} (u : P x) (p : x ≡ y)
     → ((x , u) ≡ (y , tr P p u))
lift u (refl x) = refl (x , u)

-- Lemma 2.3.4.
apd : {A : 𝒰 𝒾} {P : A → 𝒰 𝒿} (f : (x : A) → P x) {x y : A}
      (p : x ≡ y) → tr P p (f x) ≡ f y
apd f (refl x) = refl (f x)

-- Lemma 2.3.5.
trconst : {A : 𝒰 𝒾} (B : 𝒰 𝒿) {x y : A}
          (p : x ≡ y) (b : B)
        → tr (λ - → B) p b ≡ b
trconst B (refl x) b = refl b

-- Lemma 2.3.8.
apd-trconst : {A : 𝒰 𝒾} (B : 𝒰 𝒿) {x y : A}
              (f : A → B)
              (p : x ≡ y)
            → apd f p ≡ trconst B p (f x) ∙ ap f p
apd-trconst B f (refl x) = refl (refl (f x))

-- Lemma 2.3.9.
-- (Slight generalization for the ua-∘ proof)
tr-∘ : {A : 𝒰 𝒾} (P : A → 𝒰 𝒿) {x y z : A}
       (p : x ≡ y) (q : y ≡ z)
     → (tr P q) ∘ (tr P p) ≡ tr P (p ∙ q)
tr-∘ P (refl x) (refl x) = refl id

---------------------------------------------------------------------------------

-- Section 2.4 Homotopies and equivalences

_∼_ : {X : 𝒰 𝒾} {P : X → 𝒰 𝒿} → Π P → Π P → 𝒰 (𝒾 ⊔ 𝒿)
f ∼ g = ∀ x → f x ≡ g x

∼-refl : {X : 𝒰 𝒾} {P : X → 𝒰 𝒿} (f : Π P) → (f ∼ f)
∼-refl f = λ x → (refl (f x))

∼-sym : {X : 𝒰 𝒾} {P : X → 𝒰 𝒿}
      → (f g : Π P)
      → (f ∼ g)
      → (g ∼ f)
∼-sym f g H = λ x → (H x)⁻¹

∼-trans : {X : 𝒰 𝒾} {P : X → 𝒰 𝒿}
        → (f g h : Π P)
        → (f ∼ g)
        → (g ∼ h)
        → (f ∼ h)
∼-trans f g h H1 H2 = λ x → (H1 x) ∙ (H2 x)

-- Lemma 2.4.3.
∼-naturality : {X : 𝒰 𝒾} {A : 𝒰 𝒿}
               (f g : X → A) (H : f ∼ g) {x y : X} {p : x ≡ y}
             → H x ∙ ap g p ≡ ap f p ∙ H y
∼-naturality f g H {x} {_} {refl a} = refl-right ∙ refl-left ⁻¹

-- Corollary 2.4.4.
~-id-naturality : {A : 𝒰 𝒾}
                  (f : A → A) (H : f ∼ id) {x : A}
                → (H (f x)) ≡ (ap f (H x))
~-id-naturality f H {x} = begin
    H (f x)                             ≡˘⟨ refl-right ⟩
    H (f x) ∙ (refl (f x))              ≡˘⟨ i ⟩
    H (f x) ∙ (H x ∙ (H x)⁻¹)           ≡˘⟨ ∙-assoc (H (f x)) ⟩
    (H (f x) ∙ H x) ∙ (H x)⁻¹           ≡˘⟨ ii ⟩
    (H (f x) ∙ (ap id (H x))) ∙ (H x)⁻¹ ≡⟨ iii ⟩
    (ap f (H x) ∙ (H x)) ∙ (H x)⁻¹      ≡⟨ ∙-assoc (ap f (H x)) ⟩
    ap f (H x) ∙ ((H x) ∙ (H x)⁻¹)      ≡⟨ iv ⟩
    ap f (H x) ∙ (refl (f x)) ≡⟨ refl-right ⟩
    ap f (H x) ∎
  where
    i = ap (H (f x) ∙_) (⁻¹-right∙ (H x))
    ii = ap (λ - → (H (f x) ∙ (-)) ∙ (H x)⁻¹) (ap-id (H x))
    iii = ap (_∙ (H x)⁻¹) (∼-naturality f id H)
    iv = ap (ap f (H x) ∙_) (⁻¹-right∙ (H x))


qinv : {A : 𝒰 𝒾} {B : 𝒰 𝒿} → (A → B) → 𝒰 (𝒾 ⊔ 𝒿)
qinv f = Σ g ꞉ (codomain f → domain f) , (f ∘ g ∼ id) × (g ∘ f ∼ id)

-- Example 2.4.7.
qinv-id-id : (A : 𝒰 𝒾) → qinv (𝑖𝑑 A)
qinv-id-id A = (𝑖𝑑 A) , refl , refl

is-equiv : {A : 𝒰 𝒾} {B : 𝒰 𝒿} → (A → B) → 𝒰 (𝒾 ⊔ 𝒿)
is-equiv f = (Σ g ꞉ (codomain f → domain f) , (f ∘ g ∼ id))
           × (Σ h ꞉ (codomain f → domain f) , (h ∘ f ∼ id))

invs-are-equivs : {A : 𝒰 𝒾} {B : 𝒰 𝒿} (f : A → B)
                → (qinv f) → (is-equiv f)
invs-are-equivs f ( g , α , β ) = ( (g , α) , (g , β) )

equivs-are-invs : {A : 𝒰 𝒾} {B : 𝒰 𝒿} (f : A → B)
                → (is-equiv f) → (qinv f)
equivs-are-invs f ( (g , α) , (h , β) ) = ( g , α , β' )
  where
    γ : (x : codomain f) → (g x ≡ h x)
    γ x = begin
      g x ≡˘⟨ β (g x) ⟩
      h (f (g x)) ≡⟨ ap h (α x) ⟩
      h x ∎
    β' : g ∘ f ∼ 𝑖𝑑 (domain f)
    β' x = γ (f x) ∙ β x

_≃_ : 𝒰 𝒾 → 𝒰 𝒿 → 𝒰 (𝒾 ⊔ 𝒿)
A ≃ B = Σ f ꞉ (A → B), is-equiv f

-- Helpers to get the quasi-inverse data from an equiv
≃-→ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} → X ≃ Y → (X → Y)
≃-→ (f , eqv) = f

≃-← : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} → X ≃ Y → (Y → X)
≃-← (f , eqv) =
 let (g , ε , η) = equivs-are-invs f eqv
  in g

≃-ε : {X : 𝒰 𝒾} {Y : 𝒰 𝒿}
    → (equiv : (X ≃ Y))
    → ((pr₁ equiv) ∘ (≃-← equiv) ∼ id)
≃-ε (f , eqv) =
 let (g , ε , η) = equivs-are-invs f eqv
  in ε

≃-η : {X : 𝒰 𝒾} {Y : 𝒰 𝒿}
    → (equiv : (X ≃ Y))
    → ((≃-← equiv) ∘ (pr₁ equiv) ∼ id)
≃-η (f , eqv) =
 let (g , ε , η) = equivs-are-invs f eqv
  in η

-- Lemma 2.4.12. i)
≃-refl : (X : 𝒰 𝒾) → X ≃ X
≃-refl X = ( 𝑖𝑑 X , invs-are-equivs (𝑖𝑑 X) (qinv-id-id X) )

-- Lemma 2.4.12. ii)
≃-sym : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} → X ≃ Y → Y ≃ X
≃-sym ( f , e ) =
  let ( f⁻¹ , p , q) = ( equivs-are-invs f e )
  in  ( f⁻¹ , invs-are-equivs f⁻¹ (f , q , p) )

-- Lemma 2.4.12. iii)
≃-trans-helper : {A : 𝒰 𝒾} {B : 𝒰 𝒿} {C : 𝒰 𝓀}
                 (eqvf : A ≃ B) (eqvg : B ≃ C)
               → is-equiv (pr₁ eqvg ∘ pr₁ eqvf)
≃-trans-helper ( f , ef ) ( g , eg ) =
  let ( f⁻¹ , pf , qf ) = ( equivs-are-invs f ef )
      ( g⁻¹ , pg , qg ) = ( equivs-are-invs g eg )
      h1 : ((g ∘ f) ∘ (f⁻¹ ∘ g⁻¹) ∼ id)
      h1 x = begin
        g (f (f⁻¹ (g⁻¹ x))) ≡⟨ ap g (pf (g⁻¹ x)) ⟩
        g (g⁻¹ x) ≡⟨ pg x ⟩
        x ∎
      h2 : ((f⁻¹ ∘ g⁻¹) ∘ (g ∘ f) ∼ id)
      h2 x = begin
        f⁻¹ (g⁻¹ (g (f x))) ≡⟨ ap f⁻¹ (qg (f x)) ⟩
        f⁻¹ (f x) ≡⟨ qf x ⟩
        x ∎
  in  invs-are-equivs (g ∘ f) ((f⁻¹ ∘ g⁻¹) , h1 , h2)

≃-trans : {A : 𝒰 𝒾} {B : 𝒰 𝒿} {C : 𝒰 𝓀}
        → A ≃ B → B ≃ C → A ≃ C
≃-trans eqvf@( f , ef ) eqvg@( g , eg ) =
  let ( f⁻¹ , pf , qf ) = ( equivs-are-invs f ef )
      ( g⁻¹ , pg , qg ) = ( equivs-are-invs g eg )
      h1 : ((g ∘ f) ∘ (f⁻¹ ∘ g⁻¹) ∼ id)
      h1 x = begin
        g (f (f⁻¹ (g⁻¹ x))) ≡⟨ ap g (pf (g⁻¹ x)) ⟩
        g (g⁻¹ x)           ≡⟨ pg x ⟩
        x ∎
      h2 : ((f⁻¹ ∘ g⁻¹) ∘ (g ∘ f) ∼ id)
      h2 x = begin
        f⁻¹ (g⁻¹ (g (f x))) ≡⟨ ap f⁻¹ (qg (f x)) ⟩
        f⁻¹ (f x)           ≡⟨ qf x ⟩
        x ∎
  in  ((g ∘ f) , ≃-trans-helper eqvf eqvg)

---------------------------------------------------------------------------------

-- 2.5 The higher groupoid structure of type formers

---------------------------------------------------------------------------------

-- 2.6 Cartesian product types

pair×⁼⁻¹ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} {w w' : X × Y}
        → (w ≡ w') → ((pr₁ w ≡ pr₁ w') × (pr₂ w ≡ pr₂ w'))
pair×⁼⁻¹ (refl w) = ( refl (pr₁ w) , refl (pr₂ w) )

pair×⁼ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} {w w' : X × Y}
        → ((pr₁ w ≡ pr₁ w') × (pr₂ w ≡ pr₂ w')) → (w ≡ w')
pair×⁼ {𝒾} {𝒿} {X} {Y} {w1 , w2} {w'1 , w'2} (refl w1 , refl w2) = refl (w1 , w2)

-- Theorem 2.6.2
×-≡-≃ : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} {w w' : X × Y}
      → (w ≡ w') ≃ ((pr₁ w ≡ pr₁ w') × (pr₂ w ≡ pr₂ w'))
×-≡-≃ {𝒾} {𝒿} {X} {Y} {w1 , w2} {w'1 , w'2} =
  pair×⁼⁻¹ , invs-are-equivs pair×⁼⁻¹ (pair×⁼ , α , β)
    where
      α : (pq : (w1 ≡ w'1) × (w2 ≡ w'2))
        → pair×⁼⁻¹ (pair×⁼ pq) ≡ pq
      α (refl w1 , refl w2) = refl (refl w1 , refl w2)
      β : (p : (w1 , w2 ≡ w'1 , w'2))
        → pair×⁼ (pair×⁼⁻¹ p) ≡ p
      β (refl (w1 , w2)) = refl (refl (w1 , w2))

×-uniq : {X : 𝒰 𝒾} {Y : 𝒰 𝒿} {z : X × Y}
       → z ≡ (pr₁ z , pr₂ z)
×-uniq {𝒾} {𝒿} {X} {Y} {z} = pair×⁼ (refl (pr₁ z) , refl (pr₂ z))

trA×B : (Z : 𝒰 𝒾) (A : Z → 𝒰 𝒿) (B : Z → 𝒰 𝓀)
        (z w : Z) (p : z ≡ w) (x : A z × B z)
      → tr (λ - → A - × B -) p x ≡ (tr A p (pr₁ x) , tr B p (pr₂ x))
trA×B Z A B z w (refl z) x = ×-uniq

---------------------------------------------------------------------------------

-- 2.7 Σ-types

-- Theorem 2.7.2.
pair⁼⁻¹ : {X : 𝒰 𝒾} {Y : X → 𝒰 𝒿} {w w' : Σ Y}
        → (w ≡ w') → (Σ p ꞉ (pr₁ w ≡ pr₁ w') , tr Y p (pr₂ w) ≡ (pr₂ w'))
pair⁼⁻¹ (refl w) = ( refl (pr₁ w) , refl (pr₂ w) )

pair⁼ : {X : 𝒰 𝒾} {Y : X → 𝒰 𝒿} {w w' : Σ Y}
        → (Σ p ꞉ (pr₁ w ≡ pr₁ w') , tr Y p (pr₂ w) ≡ (pr₂ w')) → (w ≡ w')
pair⁼ {𝒾} {𝒿} {X} {Y} {w1 , w2} {w'1 , w'2} (refl w1 , refl w2) = refl (w1 , w2)

Σ-≡-≃ : {X : 𝒰 𝒾} {Y : X → 𝒰 𝒿} {w w' : Σ Y}
      → (w ≡ w') ≃ (Σ p ꞉ (pr₁ w ≡ pr₁ w') , tr Y p (pr₂ w) ≡ (pr₂ w'))
Σ-≡-≃ {𝒾} {𝒿} {X} {Y} {w1 , w2} {w'1 , w'2} =
  pair⁼⁻¹ , invs-are-equivs pair⁼⁻¹ (pair⁼ , α , β)
    where
      α : (pq : (Σ p ꞉ w1 ≡ w'1 , tr Y p w2 ≡ w'2))
        → pair⁼⁻¹ (pair⁼ pq) ≡ pq
      α (refl w1 , refl w2) = refl (refl w1 , refl w2)
      β : (p : (w1 , w2 ≡ w'1 , w'2))
        → pair⁼ (pair⁼⁻¹ p) ≡ p
      β (refl (w1 , w2)) = refl (refl (w1 , w2))

-- Corollary 2.7.3.
Σ-uniq : {X : 𝒰 𝒾} {P : X → 𝒰 𝒿} (z : Σ P)
       → z ≡ (pr₁ z , pr₂ z)
Σ-uniq z = pair⁼ (refl _ , refl _)

---------------------------------------------------------------------------------

-- 2.8 The unit type

𝟙-≡-≃ : (x y : 𝟙) → (x ≡ y) ≃ 𝟙
𝟙-≡-≃ ⋆ ⋆ = f , invs-are-equivs f (g , α , β)
  where
    f : ⋆ ≡ ⋆ → 𝟙
    f p = ⋆
    g : 𝟙 → ⋆ ≡ ⋆
    g ⋆ = refl ⋆
    α : (p : 𝟙) → f (g p) ≡ p
    α ⋆ = refl ⋆
    β : (p : ⋆ ≡ ⋆) → g (f p) ≡ p
    β (refl ⋆) = refl (refl ⋆)

𝟙-isProp : (x y : 𝟙) → (x ≡ y)
𝟙-isProp x y =
  let (f , ((g , f-g) , (h , h-f))) = 𝟙-≡-≃ x y
   in h ⋆

---------------------------------------------------------------------------------

-- 2.9 Π-types and the function extensionality axiom

happly : {A : 𝒰 𝒾} {B : A → 𝒰 𝒿} {f g : Π B}
       → f ≡ g → f ∼ g
happly p x = ap (λ - → - x) p

has-funext : (𝒾 𝒿 : Level) → 𝒰 ((𝒾 ⊔ 𝒿)⁺)
has-funext 𝒾 𝒿 = {A : 𝒰 𝒾} {B : A → 𝒰 𝒿} (f g : Π B)
               → is-equiv (happly {𝒾} {𝒿} {A} {B} {f} {g})

qinv-fe : has-funext 𝒾 𝒿 → {A : 𝒰 𝒾} {B : A → 𝒰 𝒿}
          (f g : Π B) → qinv happly
qinv-fe fe f g = equivs-are-invs happly (fe f g)

funext : {A : 𝒰 𝒾} {B : A → 𝒰 𝒿}
       → has-funext 𝒾 𝒿 → {f g : Π B}
       → f ∼ g → f ≡ g
funext fe {f} {g} htpy =
  let (funext , η , ε ) = qinv-fe fe f g
   in funext htpy

-- Slightly generalized
≡fe-comp : {A : 𝒰 𝒾} {B : A → 𝒰 𝒿}
         → (fe : has-funext 𝒾 𝒿) → {f g : Π B}
         → (h : f ∼ g)
         → happly (funext fe h) ≡ h
≡fe-comp fe {f} {g} h =
  let (funext , η , ε ) = qinv-fe fe f g
   in η h

≡fe-uniq : {A : 𝒰 𝒾} {B : A → 𝒰 𝒿}
         → (fe : has-funext 𝒾 𝒿) → {f g : Π B}
         → (p : f ≡ g)
         → p ≡ funext fe (happly p)
≡fe-uniq fe {f} {g} p =
  let (funext , η , ε ) = qinv-fe fe f g
   in (ε p)⁻¹

tr-f : (X : 𝒰 𝒾) (A : X → 𝒰 𝒿) (B : X → 𝒰 𝓀)
      (x₁ x₂ : X) (p : x₁ ≡ x₂) (f : A x₁ → B x₁)
    → tr (λ x → (A x → B x)) p f ≡ (λ x → tr B p (f (tr A (p ⁻¹) x)))
tr-f X A B x₁ x₂ (refl x₁) f = refl f

---------------------------------------------------------------------------------

-- 2.10 Universes and the univalence axiom

-- I need this helper to delay the pattern match in `idtoeqv`, while
-- still being able to use this same function in other places, like in
-- the construction of `ua-∘`.
idtoeqv-helper : {X Y : 𝒰 𝒾} (p : X ≡ Y) → is-equiv (tr (λ C → C) p)
idtoeqv-helper (refl X) = invs-are-equivs (𝑖𝑑 X) (qinv-id-id X)

idtoeqv : {X Y : 𝒰 𝒾} → X ≡ Y → X ≃ Y
idtoeqv {𝒾} {X} {Y} p = tr (λ C → C) p , (idtoeqv-helper p)

is-univalent : (𝒾 : Level) → 𝒰 (𝒾 ⁺)
is-univalent 𝒾 = (X Y : 𝒰 𝒾) → is-equiv (idtoeqv {𝒾} {X} {Y})

qinv-ua : is-univalent 𝒾 → (X Y : 𝒰 𝒾) → qinv idtoeqv
qinv-ua ua X Y = equivs-are-invs idtoeqv (ua X Y)

ua : is-univalent 𝒾 → {X Y : 𝒰 𝒾} → X ≃ Y → X ≡ Y
ua u {X} {Y} eqv =
  let (ua , idtoeqv∘ua , ua∘idtoeqv) = qinv-ua u X Y
   in ua eqv

-- Helper
id∼idtoeqv∘ua : (u : is-univalent 𝒾)
              → {X Y : 𝒰 𝒾} (eqv : X ≃ Y)
              → eqv ≡ idtoeqv (ua u eqv)
id∼idtoeqv∘ua u {X} {Y} eqv =
  let (ua , idtoeqv∘ua , ua∘idtoeqv) = qinv-ua u X Y
   in (idtoeqv∘ua eqv)⁻¹

≡u-comp : (u : is-univalent 𝒾)
        → {X Y : 𝒰 𝒾} (eqv : X ≃ Y) (x : X)
        → tr (λ C → C) (ua u eqv) x ≡ pr₁ eqv x
≡u-comp u {X} {Y} eqv x =
 happly q x
  where
   p : idtoeqv (ua u eqv) ≡ eqv
   p = (id∼idtoeqv∘ua u eqv)⁻¹
   q : tr (λ C → C) (ua u eqv) ≡ pr₁ eqv
   q = ap pr₁ p

≡u-uniq : (u : is-univalent 𝒾)
        → {X Y : 𝒰 𝒾} (p : X ≡ Y)
        → p ≡ ua u (idtoeqv p)
≡u-uniq u {X} {Y} p =
  let (ua , idtoeqv∘ua , ua∘idtoeqv) = qinv-ua u X Y
   in (ua∘idtoeqv p)⁻¹

ua-id : (u : is-univalent 𝒾)
      → {A : 𝒰 𝒾}
      → refl A ≡ ua u (≃-refl A)
ua-id u {A} = begin
  refl A                  ≡⟨ ≡u-uniq u (refl A) ⟩
  ua u (idtoeqv (refl A)) ≡⟨⟩
  ua u (≃-refl A)         ∎

ua-∘ : (u : is-univalent 𝒾)
     → {X Y Z : 𝒰 𝒾} (eqvf : X ≃ Y) (eqvg : Y ≃ Z)
     → ua u eqvf ∙ ua u eqvg ≡ ua u (≃-trans eqvf eqvg)
ua-∘ u {X} {Y} {Z} eqvf eqvg = proof ⁻¹
 where
  p = ua u eqvf
  q = ua u eqvg

  idtoeqv-∙ : ≃-trans (idtoeqv p) (idtoeqv q) ≡ idtoeqv (p ∙ q)
  idtoeqv-∙ = begin
     ≃-trans (idtoeqv p) (idtoeqv q)                 ≡⟨⟩
     ≃-trans (tr (λ C → C) p , idtoeqv-helper p)
       (tr (λ C → C) q , idtoeqv-helper q)           ≡⟨⟩
     ((tr (λ C → C) q) ∘ (tr (λ C → C) p) ,
       ≃-trans-helper (idtoeqv p) (idtoeqv q))       ≡⟨ pair⁼((tr-∘ id p q) ,
                                                          refl _) ⟩
     (tr (λ C → C) (p ∙ q) ,
       tr (λ - → is-equiv -) (tr-∘ id p q)
         (≃-trans-helper (idtoeqv p) (idtoeqv q)) )  ≡⟨ pair⁼(refl _ ,
                                                        lemma p q) ⟩
     (tr (λ C → C) (p ∙ q) , idtoeqv-helper (p ∙ q)) ≡⟨⟩
     idtoeqv (p ∙ q) ∎
    where
     lemma : (p : X ≡ Y) (q : Y ≡ Z)
           → tr is-equiv (tr-∘ id p q)
              (≃-trans-helper (idtoeqv p) (idtoeqv q))
             ≡ idtoeqv-helper (p ∙ q)
     lemma (refl X) (refl X) = refl _

  proof : ua u (≃-trans eqvf eqvg) ≡ ua u eqvf ∙ ua u eqvg
  proof = begin
   ua u (≃-trans eqvf eqvg)               ≡⟨ ap (λ - → ua u (≃-trans - eqvg))
                                               (id∼idtoeqv∘ua u eqvf)         ⟩
   ua u (≃-trans (idtoeqv p) eqvg)        ≡⟨ ap (λ - → ua u
                                                (≃-trans (idtoeqv p) -))
                                               (id∼idtoeqv∘ua u eqvg)         ⟩
   ua u (≃-trans (idtoeqv p) (idtoeqv q)) ≡⟨ ap (λ - → ua u -) idtoeqv-∙      ⟩
   ua u (idtoeqv (p ∙ q))                 ≡˘⟨ ≡u-uniq u (p ∙ q)               ⟩
   ua u eqvf ∙ ua u eqvg                  ∎

-- Lemma for next theorem
tr-_∼id : (fe : has-funext 𝒾 𝒾)
        → {X : 𝒰 𝒾} {f : X → X}
        → (h : f ∼ id)
        → tr (_∼ id) (funext fe h) h ≡ refl
tr-_∼id fe {X} {f} h = begin
  tr (_∼ id) (funext fe h) h                      ≡⟨ i ⟩
  tr (_∼ id) (funext fe (happly (funext fe h))) h ≡⟨ ii ⟩
  tr (_∼ id) (funext fe (happly (funext fe h)))
      (happly (funext fe h))                      ≡⟨ iii (funext fe h) ⟩
  refl ∎
 where
  i = ap (λ - → tr (_∼ id) (funext fe -) h) (≡fe-comp fe h)⁻¹
  ii = ap (λ - → tr (_∼ id) (funext fe (happly (funext fe h))) -)
           (≡fe-comp fe h)⁻¹
  iii : (p : f ≡ id) → tr (_∼ id) (funext fe (happly p)) (happly p) ≡ refl
  iii (refl f) = ap (λ - → tr (_∼ id) - (happly (refl f)))
                     (≡fe-uniq fe (refl f))⁻¹

ua⁻¹ : has-funext 𝒾 𝒾
     → (u : is-univalent 𝒾)
     → {X Y : 𝒰 𝒾} (eqv : X ≃ Y)
     → (ua u eqv)⁻¹ ≡ ua u (≃-sym eqv)
ua⁻¹ fe u {X} {Y} eqvf@(f , e) =
  sufficient (ua-∘ u eqvf⁻¹ eqvf ∙ claim2)
 where
  p = ua u eqvf
  eqvf⁻¹ = ≃-sym eqvf
  f⁻¹ = pr₁ eqvf⁻¹
  q = ua u eqvf⁻¹

  sufficient : (ua u eqvf⁻¹ ∙ ua u eqvf ≡ refl Y)
             → (ua u eqvf)⁻¹ ≡ ua u eqvf⁻¹
  sufficient p = begin
   (ua u eqvf)⁻¹                             ≡˘⟨ refl-left ⟩
   refl Y ∙ (ua u eqvf)⁻¹                    ≡⟨ ap (_∙ (ua u eqvf)⁻¹) (p ⁻¹) ⟩
   (ua u eqvf⁻¹ ∙ ua u eqvf) ∙ (ua u eqvf)⁻¹ ≡⟨ ∙-assoc (ua u eqvf⁻¹)        ⟩
   ua u eqvf⁻¹ ∙ (ua u eqvf ∙ (ua u eqvf)⁻¹) ≡⟨ ap (ua u eqvf⁻¹ ∙_)
                                                 (⁻¹-right∙ (ua u eqvf))     ⟩
   ua u eqvf⁻¹ ∙ refl X                      ≡⟨ refl-right                   ⟩
   ua u eqvf⁻¹                               ∎

  claim1 : ≃-trans eqvf⁻¹ eqvf ≡ ≃-refl Y
  claim1 = pair⁼ (i , ii)
   where
    i : (f ∘ f⁻¹) ≡ id
    i = funext fe (≃-η eqvf⁻¹)
    id-equiv : is-equiv id
    id-equiv = tr is-equiv i (≃-trans-helper eqvf⁻¹ (f , e))
    g h : Y → Y
    g = pr₁ (pr₁ id-equiv)
    h = pr₁ (pr₂ id-equiv)
    α = pr₂ (pr₁ id-equiv)
    β = pr₂ (pr₂ id-equiv)

    ii : ((g , α) , (h , β)) ≡ ((id , refl) , (id , refl))
    ii = pair×⁼(pair⁼(iia , iib) , pair⁼(iic , iid))
     where
      iia : g ≡ id
      iia = funext fe α
      iib : tr (_∼ id) iia α ≡ refl
      iib = tr-_∼id fe α
      iic : h ≡ id
      iic = funext fe β
      iid : tr (_∼ id) iic β ≡ refl
      iid = tr-_∼id fe β

  claim2 : ua u (≃-trans eqvf⁻¹ eqvf) ≡ refl Y
  claim2 = ap (ua u) claim1 ∙ ((≡u-uniq u (refl Y))⁻¹)

-- Note: Univalence could be expressed like this
Univalence : 𝓤ω
Univalence = ∀ i → is-univalent i

---------------------------------------------------------------------------------

-- 2.11 Identity type

-- Lemma 2.11.2.
trHomc- : {A : 𝒰 𝒾} (a : A) {x₁ x₂ : A} (p : x₁ ≡ x₂) (q : a ≡ x₁)
          → tr (λ x → a ≡ x) p q ≡ q ∙ p
trHomc- a (refl _) (refl _) = refl-right ⁻¹

trHom-c : {A : 𝒰 𝒾} (a : A) {x₁ x₂ : A} (p : x₁ ≡ x₂) (q : x₁ ≡ a)
          → tr (λ x → x ≡ a) p q ≡ p ⁻¹ ∙ q
trHom-c a (refl _) (refl _) = refl-right ⁻¹

trHom─ : {A : 𝒰 𝒾} {x₁ x₂ : A} (p : x₁ ≡ x₂) (q : x₁ ≡ x₁)
          → tr (λ x → x ≡ x) p q ≡ p ⁻¹ ∙ q ∙ p
trHom─ (refl _) q = (ap (_∙ refl _) refl-left ∙ refl-right) ⁻¹

-- Theorem 2.11.3.
tr-fx≡gx : {A : 𝒰 𝒾} {B : 𝒰 𝒿} (f g : A → B) {a a' : A}
           (p : a ≡ a') (q : f a ≡ g a)
         → tr (λ x → f x ≡ g x) p q ≡ (ap f p)⁻¹ ∙ q ∙ (ap g p)
tr-fx≡gx f g (refl a) q = (refl-left)⁻¹ ∙ (refl-right)⁻¹

-- Theorem 2.11.5.
tr-x≡x-≃ : {A : 𝒰 𝒾} {a a' : A}
           (p : a ≡ a') (q : a ≡ a) (r : a' ≡ a')
         → (tr (λ x → x ≡ x) p q ≡ r) ≃ (q ∙ p ≡ p ∙ r)
tr-x≡x-≃ {𝒾} {A} {a} {a'} (refl a) q r =
  map , invs-are-equivs map (map⁻¹ , ε , η)
 where
  map : q ≡ r → (q ∙ refl a ≡ refl a ∙ r)
  map eq = refl-right ∙ eq ∙ (refl-left)⁻¹
  map⁻¹ : (q ∙ refl a ≡ refl a ∙ r) → (q ≡ r)
  map⁻¹ eq' = (refl-right)⁻¹ ∙ eq' ∙ refl-left
  ε : map ∘ map⁻¹ ∼ id
  ε eq' = begin
    refl-right ∙ ((refl-right)⁻¹ ∙ eq' ∙ refl-left) ∙ (refl-left)⁻¹ ≡˘⟨ i ⟩
    refl-right ∙ ((refl-right)⁻¹ ∙ eq') ∙ refl-left ∙ (refl-left)⁻¹ ≡˘⟨ ii ⟩
    refl-right ∙ (refl-right)⁻¹ ∙ eq' ∙ refl-left ∙ (refl-left)⁻¹   ≡⟨ iii ⟩
    refl _ ∙ eq' ∙ refl-left ∙ (refl-left)⁻¹                        ≡⟨ iv ⟩
    eq' ∙ refl-left ∙ (refl-left)⁻¹                                 ≡⟨ v ⟩
    eq' ∙ (refl-left ∙ (refl-left)⁻¹)                               ≡⟨ vi ⟩
    eq' ∙ refl _                                                    ≡⟨ vii ⟩
    eq' ∎
   where
    i   = ap (_∙ (refl-left)⁻¹) (∙-assoc refl-right)
    ii  = ap (λ - → - ∙ refl-left ∙ (refl-left)⁻¹) (∙-assoc refl-right)
    iii = ap (λ - → - ∙ eq' ∙ refl-left ∙ (refl-left)⁻¹) (⁻¹-right∙ refl-right)
    iv  = ap (λ - → - ∙ refl-left ∙ (refl-left)⁻¹) refl-left
    v   = ∙-assoc eq'
    vi  = ap (eq' ∙_) (⁻¹-right∙ refl-left)
    vii = refl-right
  η : map⁻¹ ∘ map ∼ id
  η eq = begin
    (refl-right)⁻¹ ∙ (refl-right ∙ eq ∙ (refl-left)⁻¹) ∙ refl-left ≡˘⟨ i ⟩
    (refl-right)⁻¹ ∙ (refl-right ∙ eq) ∙ (refl-left)⁻¹ ∙ refl-left ≡˘⟨ ii ⟩
    (refl-right)⁻¹ ∙ refl-right ∙ eq ∙ (refl-left)⁻¹ ∙ refl-left   ≡⟨ iii ⟩
    refl _ ∙ eq ∙ (refl-left)⁻¹ ∙ refl-left                        ≡⟨ iv ⟩
    eq ∙ (refl-left)⁻¹ ∙ refl-left                                 ≡⟨ v ⟩
    eq ∙ ((refl-left)⁻¹ ∙ refl-left)                               ≡⟨ vi ⟩
    eq ∙ refl _                                                    ≡⟨ vii ⟩
    eq ∎
   where
    i   = ap (_∙ refl-left) (∙-assoc ((refl-right)⁻¹))
    ii  = ap (λ - → - ∙ (refl-left)⁻¹ ∙ refl-left) (∙-assoc ((refl-right)⁻¹))
    iii = ap (λ - → - ∙ eq ∙ (refl-left)⁻¹ ∙ refl-left) (⁻¹-left∙ refl-right)
    iv  = ap (λ - → - ∙ (refl-left)⁻¹ ∙ refl-left) refl-left
    v   = ∙-assoc eq
    vi  = ap (eq ∙_) (⁻¹-left∙ refl-left)
    vii = refl-right


---------------------------------------------------------------------------------

-- 2.12 Coproducts

𝟙-is-not-𝟘 : 𝟙 ≢ 𝟘
𝟙-is-not-𝟘 p = tr id p ⋆

₁-is-not-₀ : ₁ ≢ ₀
₁-is-not-₀ p = 𝟙-is-not-𝟘 q
 where
  f : 𝟚 → 𝒰 lzero
  f ₀ = 𝟘
  f ₁ = 𝟙
  q : 𝟙 ≡ 𝟘
  q = ap f p

---------------------------------------------------------------------------------

-- 2.15 Universal properties

-- Theorem 2.15.7.
ΠΣ-comm : {X : 𝒰 𝒾} {A : X → 𝒰 𝒿} {P : (x : X) → A x → 𝒰 𝓀}
        → has-funext 𝒾 (𝒿 ⊔ 𝓀)
        → ((x : X) → Σ a ꞉ (A x) , P x a)
           ≃ (Σ g ꞉ ((x : X) → A x) , ((x : X) → P x (g x)))
ΠΣ-comm {𝒾} {𝒿} {𝓀} {X} {A} {P} fe = map , invs-are-equivs map (map⁻¹ , ε , η)
  where
    map : ((x : X) → Σ a ꞉ (A x) , P x a)
        → (Σ g ꞉ ((x : X) → A x) , ((x : X) → P x (g x)))
    map f = (λ x → pr₁ (f x)) , (λ x → pr₂ (f x))
    map⁻¹ : (Σ g ꞉ ((x : X) → A x) , ((x : X) → P x (g x)))
          → ((x : X) → Σ a ꞉ (A x) , P x a)
    map⁻¹ (g , h) = λ x → (g x , h x)
    ε : map ∘ map⁻¹ ∼ id
    ε (g , h) = refl _
    η : map⁻¹ ∘ map ∼ id
    η f = funext fe (λ x → (Σ-uniq (f x))⁻¹)
