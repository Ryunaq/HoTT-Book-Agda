module Chapter6.HITs where

open import Chapter5.Exercises public

-- See https://homotopytypetheory.org/2011/04/23/running-circles-around-in-your-proof-assistant/

---------------------------------------------------------------------------------

-- Circle

module Circle where
  private
    data S : ๐ฐโ where
      point : S

  ๐ยน : ๐ฐโ
  ๐ยน = S

  base : S
  base = point

  postulate loop : base โก base

  ๐ยน-ind : (P : ๐ยน โ ๐ฐ ๐พ)
         โ (b : P base)
         โ (l : tr P loop b โก b)
         โ ((x : ๐ยน) โ P x)
  ๐ยน-ind P b l point = b

  postulate ๐ยน-ind-comp : (P : ๐ยน โ ๐ฐ ๐พ)
                        โ (b : P base)
                        โ (l : tr P loop b โก b)
                        โ (apd (๐ยน-ind P b l) loop โก l)

open Circle public

---------------------------------------------------------------------------------

-- Interval

module Interval where
  private
    data I : ๐ฐโ where
      Zero : I
      One  : I

  ๐ : ๐ฐโ
  ๐ = I

  0แตข : ๐
  0แตข = Zero

  1แตข : ๐
  1แตข = One

  postulate seg : 0แตข โก 1แตข

  ๐-rec : (B : ๐ฐ ๐พ)
        โ (bโ bโ : B)
        โ (s : bโ โก bโ)
        โ ๐ โ B
  ๐-rec B bโ bโ s Zero = bโ
  ๐-rec B bโ bโ s One = bโ

  ๐-ind : (P : ๐ โ ๐ฐ ๐พ)
        โ (bโ : P 0แตข)
        โ (bโ : P 1แตข)
        โ (s : tr P seg bโ โก bโ)
        โ ((x : ๐) โ P x)
  ๐-ind P bโ bโ s Zero = bโ
  ๐-ind P bโ bโ s One = bโ

  postulate ๐-rec-comp : (B : ๐ฐ ๐พ)
                       โ (bโ bโ : B)
                       โ (s : bโ โก bโ)
                       โ (ap (๐-rec B bโ bโ s) seg โก s)
  postulate ๐-ind-comp : (P : ๐ โ ๐ฐ ๐พ)
                       โ (bโ : P 0แตข)
                       โ (bโ : P 1แตข)
                       โ (s : tr P seg bโ โก bโ)
                       โ (apd (๐-ind P bโ bโ s) seg โก s)

open Interval public

---------------------------------------------------------------------------------

-- Suspensions

module Suspension where
  private
    data Sus (A : ๐ฐ ๐พ) : ๐ฐ ๐พ where
      Zero : Sus A
      One : Sus A

  ๐จ : (A : ๐ฐ ๐พ) โ ๐ฐ ๐พ
  ๐จ A = Sus A

  N : (A : ๐ฐ ๐พ) โ (Sus A)
  N A = Zero

  S : (A : ๐ฐ ๐พ) โ (Sus A)
  S A = One

  postulate merid : (A : ๐ฐ ๐พ) โ A โ N A โก S A

  ๐จ-rec : (A : ๐ฐ ๐พ) (B : ๐ฐ ๐ฟ)
        โ (n s : B)
        โ (m : A โ (n โก s))
        โ ๐จ A โ B
  ๐จ-rec A B n s m Zero = n
  ๐จ-rec A B n s m One = s

  ๐จ-ind : (A : ๐ฐ ๐พ) (P : ๐จ A โ ๐ฐ ๐ฟ)
        โ (n : P (N A)) โ (s : P (S A))
        โ (m : (a : A) โ tr P (merid A a) n โก s)
        โ ((x : ๐จ A) โ P x)
  ๐จ-ind A P n s m Zero = n
  ๐จ-ind A P n s m One = s

  postulate ๐จ-rec-comp : (A : ๐ฐ ๐พ) (B : ๐ฐ ๐ฟ)
              โ (n s : B)
              โ (m : A โ (n โก s))
              โ ((a : A) โ ap (๐จ-rec A B n s m) (merid A a) โก (m a))

  postulate ๐จ-ind-comp : (A : ๐ฐ ๐พ) (P : ๐จ A โ ๐ฐ ๐ฟ)
              โ (n : P (N A)) โ (s : P (S A))
              โ (m : (a : A) โ tr P (merid A a) n โก s)
              โ ((a : A) โ (apd (๐จ-ind A P n s m) (merid A a) โก m a))

open Suspension public

