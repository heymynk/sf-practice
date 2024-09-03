/**
 * @description       : Write a trigger on the Account when the Account is updated check all opportunities related to the account. Update all opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class AccOpp30DaysHandler {
    public static void handleOppStageUpdate(List<Account> newAccounts, Map<Id, Account> oldAccounts ) {
        Set<Id> accIds = new Set<Id>();

        if(!newAccounts.isEmpty()){
            for(Account acc : newAccounts){
                Account oldAcc = oldAccounts.get(acc.Id);
                if(oldAcc != null && acc.Id != oldAcc.Id){

                    accIds.add(acc.Id);
                }
            }
        }

        if(!accIds.isEmpty()){
            Date day30 = date.today() - 30;
            List<Opportunity> oppList  = [SELECT Id, AccountId, StageName, Test_Created_Date__c
                                        FROM Opportunity
                                        WHERE AccountId IN :accIds
                                        ];

            

            List<Opportunity> listToUpdate = new List<Opportunity>();

            if(!oppList.isEmpty()){
                for(Opportunity opp : oppList){
                    if(opp.Test_Created_Date__c < day30 && opp.StageName != 'Closed Won'){
                        opp.StageName = 'Closed Lost';
                        opp.CloseDate = date.today();
                        listToUpdate.add(opp);
                    }
                }

                if(!listToUpdate.isEmpty()){
                    update listToUpdate;
                }
            }

        }
    }
}