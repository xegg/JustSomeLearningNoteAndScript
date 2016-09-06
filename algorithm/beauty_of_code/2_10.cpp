(max, min) Search(arr, b, e) {
    if(e - b <= 1) {
        if(arr[b] < arr[e])
            return (arr[e], arrb]);
        else {
            return (arr[b], arr[e]);
        }
    }

    (maxL, minL) = Search(arr, b, b + (e - b) / 2);
    (maxR, minR) = Search(arr, b + (e - b) / 2 + 1, e);
    if (MaxL > MaxR)
        maxV = MaxL;
    else
        maxV = MaxR;

    if (minL < minR)
        minV = minL;
    else
        minV = minR;

    return (maxV, minV);
}
