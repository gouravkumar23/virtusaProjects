import java.util.*;

class Book {
    int id;
    String title;
    String author;
    boolean isIssued;

    Book(int id, String title, String author) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.isIssued = false;
    }
}

class User {
    int id;
    String name;

    User(int id, String name) {
        this.id = id;
        this.name = name;
    }
}

public class LibrarySystem {
    public static void main(String[] args) {
        ArrayList<Book> books = new ArrayList<>();
        ArrayList<User> users = new ArrayList<>();
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n--- Library System ---");
            System.out.println("1. Add Book");
            System.out.println("2. Remove Book");
            System.out.println("3. Register User");
            System.out.println("4. Issue Book");
            System.out.println("5. Return Book");
            System.out.println("6. Search Book");
            System.out.println("7. Exit");
            int choice = sc.nextInt();
            sc.nextLine();

            if (choice == 1) {
                System.out.print("ID: "); int id = sc.nextInt(); sc.nextLine();
                System.out.print("Title: "); String t = sc.nextLine();
                System.out.print("Author: "); String a = sc.nextLine();
                books.add(new Book(id, t, a));
            } else if (choice == 2) {
                System.out.print("Book ID to remove: "); int rid = sc.nextInt();
                books.removeIf(b -> b.id == rid);
            } else if (choice == 3) {
                System.out.print("User ID: "); int id = sc.nextInt(); sc.nextLine();
                System.out.print("Name: "); String n = sc.nextLine();
                users.add(new User(id, n));
            } else if (choice == 4) {
                System.out.print("Book ID: "); int bid = sc.nextInt();
                for (Book b : books) {
                    if (b.id == bid && !b.isIssued) {
                        b.isIssued = true;
                        System.out.println("Book Issued Successfully!");
                    }
                }
            } else if (choice == 5) {
                System.out.print("Book ID: "); int bid = sc.nextInt();
                System.out.print("Days Overdue: "); int days = sc.nextInt();
                for (Book b : books) {
                    if (b.id == bid && b.isIssued) {
                        b.isIssued = false;
                        int fine = days * 2;
                        System.out.println("Returned! Fine: $" + fine);
                    }
                }
            } else if (choice == 6) {
                System.out.print("Search Title: "); String s = sc.nextLine();
                for (Book b : books) {
                    if (b.title.toLowerCase().contains(s.toLowerCase())) {
                        System.out.println(b.id + ": " + b.title + " by " + b.author + " (Issued: " + b.isIssued + ")");
                    }
                }
            } else if (choice == 7) {
                break;
            }
        }
    }
}