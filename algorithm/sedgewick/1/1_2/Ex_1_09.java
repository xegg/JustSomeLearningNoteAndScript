import java.util.Arrays;
public class Ex_1_09 {

    // precondition: array a[] is sorted
    public static int rank(int key, int[] a, Counter c) {
        int lo = 0;
        int hi = a.length - 1;
        while (lo <= hi) {
            c.increment();
            // Key is in a[lo..hi] or not present.
            int mid = lo + (hi - lo) / 2;
            if      (key < a[mid]) hi = mid - 1;
            else if (key > a[mid]) lo = mid + 1;
            else return mid;
        }
        return -1;
    }

    public static void main(String[] args) {
        int[] whitelist = In.readInts(args[0]);

        Arrays.sort(whitelist);

        // read key; print if not in whitelist
        Counter c = new Counter("calls");
        while (!StdIn.isEmpty()) {
            int key = StdIn.readInt();
            if (rank(key, whitelist, c) == -1)
                StdOut.println(key);
        }
        StdOut.println(c);
    }
}
