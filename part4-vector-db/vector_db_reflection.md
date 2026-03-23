## Vector DB Use Case

No,and framing keyword search as merely insuffcient undersells the problem.It would actively mislead lawyers into a false sense of completeness.

Consider a clause governing liability caps.A lawyer asking **"What limits the firm's financial exposure?"** finds nothing via keyword search ,because the contract may express the same obligation as the ***"aggregate damages recoverable shall not exceed the fees paid in the preceding  twelve months"** or **"neither party shall be liable for consequential losses howsoever arising"**.No shared keywords but identical legal significance.The system returns silence;the lawyer assumes the clause does not exist and advises the client accordingly .That is not an edge case, it is how contracts are routinely drafted ,sometimes deliberately ,to obscure unfavourable terms .

**Vector databases** resolve this by operating at the level of intent rather than a vocabulary .Every paragraph is chunked and encoded into an embedding vector that captures its semantic position in language space . A lawyer's plain-English query is encoded into the same space and the system retrieves paragraphs by cosine similarity i.e directional proximity not character overlap .A clause about **"aggregate liablity ceilings"** and a query about **"financial exposure limits"** land near each other even with zero shared words .

From a systems design standpoint,this architecture scales across an entire contract repository,supports iterative queries without re-scanning raw text,and can be composed with generative layer to synthesize direct answers,turning passive retrieval into an active legal reasoning tool.



