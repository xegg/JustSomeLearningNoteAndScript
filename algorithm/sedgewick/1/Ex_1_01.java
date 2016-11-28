public class Ex_1_01 {

    public static void main(String[] args) {
        StdOut.println((0+15)/2);
        StdOut.println(2.0e-6*10000000.1);
        StdOut.println(true && false || true && true);

        StdOut.println((1+2.236)/2);
        StdOut.println(1+2+3+4.0);
        StdOut.println(4.1 >= 4);
        StdOut.println(1+2+"3");
        StdOut.println();

        int A = Integer.parseInt(args[0]);
        int B = Integer.parseInt(args[1]);
        int C = Integer.parseInt(args[2]);

        if (A == B && B == C) {
            StdOut.println("equal");
        } else {
            StdOut.println("not equal");
        }


    }

}
