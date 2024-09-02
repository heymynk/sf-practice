/**
 * @description       : Handler to update the "Latest Case Inserted" field on the Account when a new Case is inserted.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class LatestCaseInsertedHandler {
    public static void handleLatestCaseInserted(List<Case> newCases){
        System.debug('=== START handleLatestCaseInserted ===');
        System.debug('Number of new Cases: ' + newCases.size());

        Set<Id> accIds = new Set<Id>();

        // Step 1: Populate the set with Account IDs from the inserted Cases.
        if(!newCases.isEmpty()){
            for(Case cs : newCases){
                if(cs.AccountId != null){
                    accIds.add(cs.AccountId);
                    System.debug('Added AccountId to set: ' + cs.AccountId);
                }
            }
        }

        if(!accIds.isEmpty()){
            // Step 2: Query Accounts associated with the retrieved Account IDs and store them in a map.
            Map<Id, Account> accMap = new Map<Id, Account>([
                SELECT Id, Latest_Case_Inserted__c 
                FROM Account 
                WHERE Id IN :accIds
            ]);
            System.debug('Number of Accounts queried: ' + accMap.size());

            // Step 3: Create a map to hold Accounts that need to be updated.
            Map<Id, Account> mapToUpdate = new Map<Id, Account>();

            // Step 4: Iterate through the newly inserted Cases.
            if(!newCases.isEmpty()){
                for(Case cs : newCases){
                    // Check if the Account map contains the Case's Account ID.
                    if(accMap.containsKey(cs.AccountId)){
                        Account acc = accMap.get(cs.AccountId);
                        // Step 5: Update the Latest Case Inserted field if it differs from the current Case Number.
                        if(acc.Latest_Case_Inserted__c != Decimal.valueOf(cs.CaseNumber)){
                            System.debug('Updating Latest_Case_Inserted__c for AccountId: ' + acc.Id);
                            System.debug('Old Value: ' + acc.Latest_Case_Inserted__c + ', New Value: ' + Decimal.valueOf(cs.CaseNumber));
                            acc.Latest_Case_Inserted__c = Decimal.valueOf(cs.CaseNumber);
                            mapToUpdate.put(acc.Id, acc);
                        }
                    }
                }

                // Step 6: Perform the update on Accounts that need to be updated.
                if(!mapToUpdate.isEmpty()){
                    System.debug('Updating Accounts: ' + mapToUpdate.keySet());
                    update mapToUpdate.values();
                }
            }
        }

        System.debug('=== END handleLatestCaseInserted ===');
    }
}
