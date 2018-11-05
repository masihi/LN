import numpy as np
import os, sys, nltk, string, numpy as np
from nltk import word_tokenize
from pathlib import Path
# Paths

#corporaPath = Path('corpora')
#knownCorporaPath = corporaPath / 'QuestoesConhecidas.txt'
knownCorporaPath = Path(str(sys.argv[1]))
#newQuestionsPath = corporaPath / 'NovasQuestoes.txt'
newQuestionsPath = Path(str(sys.argv[2]))

#global Variables
_known_corpora_taglist = []
_known_corpora_sentences = []
_known_corpora_sentences_tokenized = []
_newQuestionsTokenized = []
_results = []

#implement distance algorithm
def min_edit_number(exit, entrance):
    n = len(exit)
    m = len(entrance)
    dist_matrix = np.zeros((n, m))
    #dist_matrix[0][0] = 0

    for j in range(1, n):
        dist_matrix[j][0] = j

    for i in range(1, m):
        dist_matrix[0][i] = i

    for j in range(1, n):
        for i in range(1, m):
            dist_matrix[j][i] = min(dist_matrix[j-1][i] + 1,
                                   dist_matrix[j-1][i-1] + cost(exit[j-1],entrance[i-1]),
                                   dist_matrix[j][i-1] + 1)
    return dist_matrix[n-1][m-1]

def cost(a,b):
    if(a==b):
        return 0
    return 1

def printResults():
    for i in _results:
        print(i)

# Separate
def tokenizeFiles():
    f = open(knownCorporaPath, 'rU')
    # one raw line per list entry
    know_corpora_lines = f.readlines()

    # Separate tag and sentence
    for i in know_corpora_lines:
        tag , sentence = i.split('\t')
        _known_corpora_taglist.append(tag)
        _known_corpora_sentences.append(sentence)

    # tokenize sentences
    for j in _known_corpora_sentences:
        _known_corpora_sentences_tokenized.append(nltk.word_tokenize(j))

    f.close()

    newFile = open(newQuestionsPath, 'rU')

    newQuestionsSentencesList = newFile.readlines()

    for g in newQuestionsSentencesList:
        _newQuestionsTokenized.append(nltk.word_tokenize(g))

    newFile.close()

tokenizeFiles()

for i in _newQuestionsTokenized:
    bestSolution = min_edit_number(i,_known_corpora_sentences_tokenized[0])
    bestIndex = 0
    for j in range(0,len(_known_corpora_sentences_tokenized)):
        value = min_edit_number(i,_known_corpora_sentences_tokenized[j])
        if(value < bestSolution):
            bestSolution = value
            bestIndex = j

    _results.append(_known_corpora_taglist[bestIndex])

printResults()
