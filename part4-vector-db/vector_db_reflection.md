## Vector DB Use Case

A traditional keyword based search would not be sufficient for the given use case.Legal contracts are written in highly formal and varied language,where the same concept can be expressed in multiple ways.For ex:- "a termination clause" might appear as conditions under which the agreement may be dissolved or "grounds for cessation of obligations".A keyword search general relies on exact or partial word matches so it would likely miss relevant sections if the wording differs from the user's query which inturn makes it unreliable for long,complex documents like a 500-page contracts.

A vector database addresses this liitation by enabling **semantic search** rather than simple keyword matching.In this approach,both the contract text i.e broken into smaller chunks and the user's query are converted into embeddings in which numerical representatioms capture meanings and context.Instead of matching words,the system compares these embeddings to find sections that are conceptually similar to the query.

This is especially useful in legal scenarios where precision and context matters a lot.A vector database can retrieve clauses that are relevant in meaning even if they do not share the exact keywords.It also allows ranking results by similarity,ensuring most relevant sections appear first.

In practice,the system would store embeddings of contract chunks in the vector database. When a lawyer asks a question,the query embedding is matched against stored vectors to retrieve the most relevant passages.This makes the search faster ,more accurate and fa more aligned with how humans interpret legal language.
