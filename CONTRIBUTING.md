
# Code Style

For variable names, please use either single characters or real words, but not non-words.
These are much easier to dictate, since they require: neither spelling out each letter in the NATO phonetic alphabet; nor manual editing; nor addition to a lexicon. 

e.g. 

```haskell

-- a single character (good), 
-- dictated as "sierra". 
s = ...

-- a real word (good),
-- dictated as "source". 
source = ...

-- a fake word that's un-utterable (not good),
-- dictated as "sierra romeo charlie",
-- since saying "surss" isn't recognizeable. 
src = ...

```

