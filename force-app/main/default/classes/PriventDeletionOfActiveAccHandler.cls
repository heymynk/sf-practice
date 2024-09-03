/**
 * @description       : Prevent users from deleting an Active Account.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class PriventDeletionOfActiveAccHandler {
    public static void preventActiveAccDeletion(List<Account> oldAcc) {

        if (!oldAcc.isEmpty()) {
            for (Account acc : oldAcc) {
                // Assuming 'Active' is the picklist value you want to check
                if (acc.Active__c == 'Yes') {
                    acc.addError('Active Account cannot be deleted');
                }
            }
        }
    }
}
