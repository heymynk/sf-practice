/**
 * @description       :
 * @author            : Mayank Singh
 * @group             :
 * @last modified on  : 01-05-2025
 * @last modified by  : Mayank Singh
 **/
public with sharing class AccountContactService {
    public static void updateActiveContacts(Set<Id> uniqueAccIds){
        List<AggregateResult> results =  [SELECT AccountId, COUNT(Id) totalContacts FROM Contact Where Active__c = true AND AccountId  IN: uniqueAccIds GROUP BY AccountId];
        
        Map<Id,Account> accountsToUpdate = new Map<Id,Account>();
        for(AggregateResult result : results){
            // get AccountId and number of contacts
            String AccId = String.valueOf(result.get('AccountId'));
            Integer totalContacts = Integer.valueOf(result.get('totalContacts'));
            
            Account acc = new Account(Id = AccID, Active_contacts__c = totalContacts);
            accountsToUpdate.put(accId, acc);
        }

        for(Id accId : uniqueAccIds){
            if(!accountsToUpdate.containsKey(accId)){
                accountsToUpdate.put(accId, new Account(Id = AccID, Active_contacts__c = 0));

            }
        }

        update accountsToUpdate.values();
    }
}