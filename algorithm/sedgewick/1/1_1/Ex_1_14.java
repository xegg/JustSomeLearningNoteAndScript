public class Ex_1_14 {

    public static void main(String[] args) {
        int number = Integer.parseInt(args[0]);
        int return_number = 0;
        for (int i = 2 ; i < number; i *= 2) {
            return_number++;
        }
        StdOut.println(return_number);
    }


}
