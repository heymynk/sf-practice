/**
 * @description       : Handles updates on Opportunities and related Accounts.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-04-2025
 * @last modified by  : Mayank Singh
 **/
public with sharing class OpportunityUpdateHandler {
    public static void updateOpportunities(List<Opportunity> newOpps, Map<Id, Opportunity> oldMap) {
        Set<Id> accountIds = new Set<Id>();

        // Collect Account IDs from Opportunities with changes
        for (Opportunity opp : newOpps) {
            if (opp.AccountId != null && opp.AccountId != oldMap.get(opp.Id).AccountId) {
                accountIds.add(opp.AccountId);
            }
        }

        // Query Accounts based on collected Account IDs
        List<Account> accounts = [SELECT Id, Phone FROM Account WHERE Id IN :accountIds];

        // Check and perform necessary updates
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : accounts) {
            if (String.isEmpty(acc.Phone)) { // Check if Phone field is empty
                acc.Phone = '000-000-0000'; // Example logic: Set a default phone number
                accountsToUpdate.add(acc);
            }
        }

        // Perform updates if necessary
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}