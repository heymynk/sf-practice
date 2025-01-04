/**
 * @description       : Ensure One Primary Contact Per Account
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-04-2025
 * @last modified by  : Mayank Singh
**/
public with sharing class onePrimaryContactHandler {
    public static Boolean isRecursive = false;

    public void ensureSinglePrimaryContact(List<Contact> newContacts, Map<Id, Contact> oldContactMap) {
        if (isRecursive) return;
        isRecursive = true;

        Map<Id, List<Contact>> accountToContacts = new Map<Id, List<Contact>>();

        // Group contacts by AccountId
        for (Contact con : newContacts) {
            if (con.AccountId != null && con.IsPrimary__c) {
                if (!accountToContacts.containsKey(con.AccountId)) {
                    accountToContacts.put(con.AccountId, new List<Contact>());
                }
                accountToContacts.get(con.AccountId).add(con);
            }
        }

        // Check existing primary contacts for each Account
        for (Id accountId : accountToContacts.keySet()) {
            List<Contact> relatedContacts = [
                SELECT Id, IsPrimary__c FROM Contact 
                WHERE AccountId = :accountId AND IsPrimary__c = true
            ];

            // If more than one primary contact is found, throw an error
            for (Contact con : accountToContacts.get(accountId)) {
                if (!relatedContacts.isEmpty() && 
                    (relatedContacts.size() > 1 || 
                    (relatedContacts.size() == 1 && !relatedContacts[0].Id.equals(con.Id)))) {
                    con.addError('Only one primary contact is allowed per Account.');
                }
            }
        }

        isRecursive = false;
    }
}