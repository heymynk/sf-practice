/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class LeadUpdateTriggerHandlerCase4 {
    public static void updateLeadCase4(List<Lead> newLeads){
        for( Lead leadRec: newLeads){
            if(leadRec.Industry == 'Healthcare'){
                leadRec.LeadSource = 'Purchased List';
                leadRec.SICCode__c = '1100';
                leadRec.Primary__c = 'Yes';
            }
        }
    }
}