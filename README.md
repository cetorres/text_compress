# text_compress

A simple text compression command line tool made in Swift.

```sh
text_compress 1.0
A simple text compression tool
Copyright © 2024 Carlos E. Torres

Usage:
	text_compress -c <Text to compress> [-i]
	text_compress -d <Text to decompress>

Example of compression:
	aaaabbbccdeefffaaa -> a4b3c2de2f3a3   (case insensitive)
	aAAabbbccdeefffaaa -> aA2ab3c2de2f3a3 (case sensitive)
```
