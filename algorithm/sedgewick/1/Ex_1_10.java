public class Ex_1_10 {

    public static void main(String[] args) {
        boolean[][] a = {{true, true}, {false, false}};
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2 ; j++) {
                if (a[i][j] == true)
                    StdOut.println('*');
                else
                    StdOut.println(' ');
            }
        }
    }


}
