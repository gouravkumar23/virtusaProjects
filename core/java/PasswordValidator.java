import java.util.Scanner;

public class PasswordValidator {

    public static boolean isValid(String password) {
        boolean hasUpper = false;
        boolean hasDigit = false;

        if (password.length() < 8) {
            System.out.println("Password too short (minimum 8 characters)");
            return false;
        }

        for (int iter = 0; iter < password.length(); iter++) {
            char ch = password.charAt(iter);

            if (Character.isUpperCase(ch)) {
                hasUpper = true;
            }
            if (Character.isDigit(ch)) {
                hasDigit = true;
            }
        }

        if (!hasUpper) {
            System.out.println("Missing an uppercase letter");
        }

        if (!hasDigit) {
            System.out.println("Missing a digit");
        }

        return hasUpper && hasDigit;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String password;

        System.out.println("=== SafeLog Password Validator ===");

        while (true) {
            System.out.print("Enter Password: ");
            password = sc.nextLine();

            if (isValid(password)) {
                System.out.println("Password is valid!");
                break;
            } else {
                System.out.println("Try again...");
            }
        }

        sc.close();
    }
}