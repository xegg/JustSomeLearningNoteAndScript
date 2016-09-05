int CalCulateStringDistance(string strA, int pABegin, int pAEnd,
        string strB, int pBBegin, int pBEnd) {
    if (pBBegin > pBEnd) {
        if (pABegin > pAEnd) {
            return 0;
        }
        else {
            return pAEnd - pABegin + 1;
        }
    }

    if (strA[pABegin] == strB[pBBegin]) {
        return CalCulateStringDistance(strA, pABegin + 1, pAEnd, strB, pBBegin + 1, pBEnd);
    }
    else {
        //三种情况
        ...
    }
}
