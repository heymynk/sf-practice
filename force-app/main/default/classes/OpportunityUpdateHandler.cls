/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-10-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class OpportunityUpdateHandler {
    public static void updateOpportunities(List<Opportunity> newAcc, Map<Id,Opportunity> oldMap) {
        Set<Id> accountIds = new Set<Id>();

        if(!newAcc.isEmpty()){
            for(Opportunity op : newAcc){
                if( op.AccountId != null && op. != oldMap.get(op.Id)){
                    accountIds.add(op.AccountId);
                }
            }
        }
        List<Account> acc = new List<Account>([Select Id, Phone from Account where Id IN : accountIds]);

        if(!acc.isEmpty()){
            for(Account ac : acc){
                if(ac.Phone != )
            }
        }

}