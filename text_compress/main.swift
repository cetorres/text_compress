//
//  main.swift
//  text_compress
//
//  Created by Carlos E. Torres on 6/26/24.
//

import Foundation

let arguments = CommandLine.arguments

if arguments.count < 2 {
    help()
}
else {
    if arguments[1] == "-c" {
        let text = arguments[2]
        let isCaseSensitive = arguments.count > 3 && arguments[3] == "-i"
        print(compress(text: text, isCaseSensitive: isCaseSensitive))
    }
    else if arguments[1] == "-d" {
        let text = arguments[2]
        print(decompress(text: text))
    }
    else {
        help()
    }
}

func help() {
    print("text_compress 1.0")
    print("A simple text compression tool")
    print("Copyright © 2024 Carlos E. Torres")
    print("\nUsage:")
    print("\ttext_compress -c <Text to compress> [-i]")
    print("\ttext_compress -d <Text to decompress>")
    print("\nExample of compression:")
    print("\taaaabbbccdeefffaaa -> a4b3c2de2f3a3   (case insensitive)")
    print("\taAAabbbccdeefffaaa -> aA2ab3c2de2f3a3 (case sensitive)\n")
}

func compress(text: String, isCaseSensitive: Bool = false) -> String {
    var textToCompress = text
    var compressedText = ""

    if text.count == 0 {
        return compressedText
    }

    if !isCaseSensitive {
        textToCompress = text.lowercased()
    }

    var count = 0
    var prevChar: Character = textToCompress[textToCompress.startIndex]

    for char in textToCompress {
        if char == prevChar {
            count += 1
        }
        else {
            compressedText += "\(prevChar)"
            if count > 1 {
                compressedText += "\(count)"
            }
            count = 1
        }
        prevChar = char
    }

    if compressedText.count > 0 || count > 0 {
        compressedText += "\(prevChar)\(count > 1 ? "\(count)" : "")"
    }

    return compressedText
}

func decompress(text: String) -> String {
    var decompressedText = ""

    if text.count == 0 {
        return decompressedText
    }

    let counts = text.split { $0.isLetter }.map(String.init)
    let chars = text.split { $0.isNumber }.map(String.init)

    if counts.count == 0 {
        return text
    }

    for i in 0..<counts.count {
        let count = Int(counts[i]) ?? 0
        let char = chars[i]
        let charRep = chars[i].last
        decompressedText += "\(char)"
        for _ in 0..<count - 1 {
            decompressedText += "\(charRep ?? " ")"
        }
    }

    if chars.count > counts.count {
        decompressedText += "\(chars.last ?? " ")"
    }

    decompressedText = decompressedText.trimmingCharacters(in: .whitespacesAndNewlines)

    return decompressedText
}
