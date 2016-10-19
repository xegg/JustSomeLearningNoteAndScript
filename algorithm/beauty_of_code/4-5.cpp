struct point {
    double x, y;
}

double Product(point A, point B, point C) {
    return (B.x, A.x) * (C.y - A.y) - (C.x - A.x) * (B.y - A.y);
}

bool isInTringle(point A, point B, point C, point D) {
    if (Prodcut(A, B, D) >= 0 && Product(B, C, D) >= 0 && Product(C, A, D) >= 0) {
        return true;
    }
    return false;
}

bool isInTringle(point A, point B, point C, point D) {
    if (area(A, B, C) + area(B, C, D) + area(C, A, D) > area(A, B, C)) {
        return false;
    }
    return true
}
