/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/

//As soon as a Lead record is created, create a Task for the Lead Owner to folloe up with the customer.

trigger LeadTriggerCase6 on Lead (after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        LeadTriggerCase6Handler.checkClosedLostReason(Trigger.new);
    }

}