import java.util.Arrays;

public class Ex_1_38 {

    // precondition: array a[] is sorted
    public static int BinarySearch (int key, int[] a) {
        int lo = 0;
        int hi = a.length - 1;
        while (lo <= hi) {
            // Key is in a[lo..hi] or not present.
            int mid = lo + (hi - lo) / 2;
            if      (key < a[mid]) hi = mid - 1;
            else if (key > a[mid]) lo = mid + 1;
            else return mid;
        }
        return -1;
    }

    public static int BruteForceSearch(int key, int[] a) {
        for (int i=0; i<a.length; i++) {
            if (a[i] == key) return i;
        }
        return -1;
    }

    public static void main(String[] args) {
        int[] whitelist = In.readInts(args[0]);
        int type = Integer.parseInt(args[1]);

        Arrays.sort(whitelist);

        // read key; print if not in whitelist
        Stopwatch s = new Stopwatch();
        if (type == 0) {
            while (!StdIn.isEmpty()) {
                int key = StdIn.readInt();
                if (BinarySearch(key, whitelist) == -1)
                    StdOut.println(key);
            }
        }
        else  {
            while (!StdIn.isEmpty()) {
                int key = StdIn.readInt();
                if (BruteForceSearch(key, whitelist) == -1)
                    StdOut.println(key);
            }
        }
        StdOut.printf("%5.1f\n", s.elapsedTime());
    }
}
