/**
 * @description       : Trigger to find Sum of all related Opportunities Amount of an Account.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class SumOfAllRealatedOppTriggerHandler {

    private static Set<Id> accIds = new Set<Id>();

    public static void sumOfOpportunity(List<Opportunity> newOpp, Map<Id, Opportunity> oldMap) {
        if (!newOpp.isEmpty()) {
            for (Opportunity opp : newOpp) {
                if (opp.AccountId != null) {
                    accIds.add(opp.AccountId);
                }
            }

            if (oldMap != null) {
                for (Opportunity oldOpp : oldMap.values()) {
                    if (oldOpp.AccountId != null) {
                        accIds.add(oldOpp.AccountId);
                    }
                }
            }

            List<AggregateResult> results = [SELECT AccountId, SUM(Amount) totalAmount
                                             FROM Opportunity
                                             WHERE AccountId IN :accIds
                                             GROUP BY AccountId];

            Map<Id, Decimal> accIdToAmountMap = new Map<Id, Decimal>();
            for (AggregateResult ar : results) {
                accIdToAmountMap.put((Id)ar.get('AccountId'), (Decimal)ar.get('totalAmount'));
            }

            List<Account> accToUpdate = new List<Account>();
            for (Id accId : accIds) {
                Account acc = new Account(Id = accId);
                if (accIdToAmountMap.containsKey(accId)) {
                    acc.Total_Opportunity_Amount__c	 = accIdToAmountMap.get(accId); 
                } else {
                    acc.Total_Opportunity_Amount__c	 = 0; 
                }
                accToUpdate.add(acc);
            }

            if (!accToUpdate.isEmpty()) {
                update accToUpdate;
            }
        }
    }
}
