/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class LeadUpdateTriggerHandler {
    public static void updateLead(List<Lead> newLeads){
        for(lead leadRec: newLeads){
            leadRec.Status = 'Working - Contacted';
        }
    }
}