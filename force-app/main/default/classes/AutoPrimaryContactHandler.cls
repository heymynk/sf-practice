/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-06-2025
 * @last modified by  : Mayank Singh
**/
public class AutoPrimaryContactHandler {
    public static void setPrimaryContact(List<Contact> newContacts) {
        Map<Id, Boolean> accountHasPrimary = new Map<Id, Boolean>();
        Map<Id, List<Contact>> accountToContacts = new Map<Id, List<Contact>>();

        // Collect Account Ids
        for (Contact con : newContacts) {
            if (con.AccountId != null) {
                if (!accountToContacts.containsKey(con.AccountId)) {
                    accountToContacts.put(con.AccountId, new List<Contact>());
                }
                accountToContacts.get(con.AccountId).add(con);
            }
        }

        // Check for existing primary contacts
        for (Id accountId : accountToContacts.keySet()) {
            List<Contact> primaryContacts = [
                SELECT Id FROM Contact WHERE AccountId = :accountId AND IsPrimary__c = true
            ];
            accountHasPrimary.put(accountId, !primaryContacts.isEmpty());
        }

        // Collect contacts for update
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Id accountId : accountToContacts.keySet()) {
            if (!accountHasPrimary.get(accountId)) {
                Contact firstContact = accountToContacts.get(accountId)[0];
                Contact contactToUpdate = new Contact(Id = firstContact.Id, IsPrimary__c = true);
                contactsToUpdate.add(contactToUpdate);
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}