/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
// Whenever a Lead record is updated and status is open- not contacted, set the Lead status to working contacted

trigger LeadUpdateTrigger on Lead (before update) {

    if(Trigger.isUpdate && Trigger.isBefore){
        LeadUpdateTriggerHandler.updateLead(Trigger.new);
    }

}