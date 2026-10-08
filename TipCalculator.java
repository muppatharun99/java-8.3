import java.util.Scanner;

public class TipCalculator {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("========================================");
        System.out.println("       Welcome to Tip Calculator         ");
        System.out.println("========================================\n");
        
        try {
            // Get bill amount
            System.out.print("Enter bill amount: ₹");
            double billAmount = scanner.nextDouble();
            
            if (billAmount < 0) {
                System.out.println("Error: Bill amount cannot be negative!");
                return;
            }
            
            // Display tip percentage options
            System.out.println("\nSelect tip percentage:");
            int[] tipPercentages = {5, 10, 15, 20, 25};
            for (int i = 0; i < tipPercentages.length; i++) {
                System.out.println((i + 1) + ". " + tipPercentages[i] + "%");
            }
            
            System.out.print("Enter your choice (1-5): ");
            int choice = scanner.nextInt();
            
            if (choice < 1 || choice > 5) {
                System.out.println("Error: Invalid choice!");
                return;
            }
            
            int tipPercentage = tipPercentages[choice - 1];
            
            // Calculate tip
            double tipAmount = billAmount * tipPercentage / 100.0;
            double totalAmount = billAmount + tipAmount;
            
            // Display results
            System.out.println("\n========================================");
            System.out.println("            Calculation Results         ");
            System.out.println("========================================");
            System.out.printf("Bill Amount:     ₹%.2f%n", billAmount);
            System.out.printf("Tip Percentage:  %d%%%n", tipPercentage);
            System.out.printf("Tip Amount:      ₹%.2f%n", tipAmount);
            System.out.printf("Total Amount:    ₹%.2f%n", totalAmount);
            System.out.println("========================================\n");
            
        } catch (Exception e) {
            System.out.println("Error: Please enter a valid bill amount and choice!");
        } finally {
            scanner.close();
        }
    }
}
