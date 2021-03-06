# Formalization of [HoTT Book](https://github.com/HoTT/book) in Agda.

A lot of my code is taken from Escardo's [notes](https://www.cs.bham.ac.uk/~mhe/HoTT-UF-in-Agda-Lecture-Notes/HoTT-UF-Agda.html).
Other references I used where [agda-unimath](https://unimath.github.io/agda-unimath/), Rijke's [formalization](https://github.com/HoTT-Intro/Agda) of his book, the [HoTT-Agda](https://github.com/HoTT/HoTT-Agda) library, and of course Agda's [standard library](https://github.com/agda/agda-stdlib).

I've tried to keep the Agda as simple as possible, while using similar naming conventions to the HoTT book.
In particular, I modified the how Agda treats universes in `Lib/Universes.agda` so its similar to the book.
Some workarounds have to be done sometimes to please agda, I've marked them with `workaround` in comments.

Following Escardo, two deliberate differences from the book are
1. I don't assume any of the axioms (univalence, rezising, etc), and instead only assume them when they are needed.
2. I take careful track of the universe indices.

Any contribution, be it in improving the readability of a proof, additional content from the book (I've skipped a ton), or just a simple typo is appreciated.
