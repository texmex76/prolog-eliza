# Eliza in Prolog

## Eliza Paper

Fundamental challenges:
- Identification of "most important" keyword in input message
- Identification of minimal context around keyword
- Choice of appropriate transformation rule
- How to reply (ingelligently) when there are no keywords
- Extension of knowledge base

The basis of Eliza is that certain keywords trigger certain transformation rules. Example: "I am very unhappy these days". Computer only understands "I am", so he will answer: "How long have you been unhappy these days?"

- I am **BLAH** => How long have you been **BLAH**?
- (0 YOU 0 ME) => (WHAT MAKES YOU THINK I 3 YOU)
  - 0 is any number of words
  - 3 is the third compoenent of the first sentence
- (0 YOU 1 ME)
  - 1 is exactly 1 word

Basic procedure  

- Input sentence is scanned from left to right
- Each word is looked up in a dictionary of keywords
- If keyword is found, only decomposition rules containing that keyword need to be tried

Problems

- Almost none of input words are in dictionary
- Associating both decomposition and reassembly rules with keywords

Keywords have rankings (in Prolog, we would just write higher-ranking ones first since it works from top to bottom)

> The system described so far is essentially one which selects a decomposition rule for the highest ranking key word found in an input text, attempts to match that text according to that decomposition rule and, failing to make a match, selects the next reassembly rule associated with the matching decomposition rule and applies it to generate an output text.

**Weizenbaum used SLIP, since we use Prolog we can omit many explicit programming instructions from the paper.** Maybe we could even argue that it's easier to program Eliza in Prolog (nowadays, Prolog hadn't been around at that time yet)

## Our Project

- Background, definition
- Our implementation
- Comparison Prolog/SLIP