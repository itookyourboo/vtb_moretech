with open('combinator_words.txt', encoding='utf8') as words:
    allWords = list(map(lambda x: x.upper().strip(), words.readlines()))

with open('combinator_words_fin.txt', encoding='utf8') as fin:
    finWords = list(map(lambda x: x.upper().strip(), fin.readlines()))

def isConsist(original, word):
    if original == word or len(original) < len(word):
        return False

    for s in word:
        if word.count(s) > original.count(s):
            return False

    return True

def getAnagrams(orig, words):
    return list(filter(lambda x: isConsist(orig, x), words))

def getRandomWords():
    return list(filter(lambda x: 6 < len(x) < 9 and
                       len(list(filter(lambda y: y in finWords,
                                       getAnagrams(x)))) != 0, allWords))

lenWords = list(filter(lambda x: 6 <= len(x) <= 9, allWords))

res = {}
for total in lenWords:
    for fin in finWords:
        if isConsist(total, fin):
            if total not in res:
                res[total] = 1
            else:
                res[total] += 1

for line in res:
    if res[line] > 2:
        print(line)

        

