/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class OpportunityTriggerCase7Handler {
    public static void updateAmountCase7(List<Opportunity> newOppRecord, Map<Id,Opportunity> oldOppRecord){

        if(!newOppRecord.isEmpty() && !oldOppRecord.isEmpty()){
            for(Opportunity newOpp : newOppRecord ){
                if(oldOppRecord.get(newOpp.Id).StageName != newOpp.StageName){
                    newOpp.Amount = newOpp.Probability * newOpp.ExpectedRevenue;
                }
            }
            System.debug('ammount calculated ');
        }

    }
}