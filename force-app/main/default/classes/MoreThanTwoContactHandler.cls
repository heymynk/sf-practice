/**
 * @description       : Handler to ensure no more than two contacts are associated with a single Account.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class MoreThanTwoContactHandler {
    public static void handleContactTrigger(List<Contact> newCon) {
        System.debug('=== START handleContactTrigger ===');
        System.debug('Number of new Contacts: ' + newCon.size());

        // Step 1: Fetch Parent AccountIds of new contacts which are inserted and store them in a Set
        Set<Id> accIds = new Set<Id>();
        if (!newCon.isEmpty()) {
            for (Contact con : newCon) {
                if (con.AccountId != null) {
                    accIds.add(con.AccountId);
                    System.debug('Added AccountId to set: ' + con.AccountId);
                }  
            }
        }

        // Step 2: Query to count the number of contacts associated with each account
        Map<Id, Integer> contactCount = new Map<Id, Integer>();
        List<AggregateResult> aggList = [SELECT AccountId, COUNT(Id) contactCount 
                                         FROM Contact 
                                         WHERE AccountId IN :accIds 
                                         GROUP BY AccountId];
        System.debug('Number of Aggregate Results: ' + aggList.size());

        if (!aggList.isEmpty()) {
            for (AggregateResult ar : aggList) {
                Id accId = (Id)ar.get('AccountId');
                Integer count = (Integer)ar.get('contactCount');
                contactCount.put(accId, count);
                System.debug('AccountId: ' + accId + ', Contact Count: ' + count);
            }
        }

        // Step 3: Prevent adding more than two contacts to an account
        if (!contactCount.isEmpty()) {
            for (Contact con : newCon) {
                if (contactCount.containsKey(con.AccountId) && contactCount.get(con.AccountId) >= 2) {
                    con.addError('Cannot add more than two contacts to one account');
                    System.debug('Error for Contact Id: ' + con.Id + ', AccountId: ' + con.AccountId + ', Contact Count: ' + contactCount.get(con.AccountId));
                }
            }
        }

        System.debug('=== END handleContactTrigger ===');
    }
}
