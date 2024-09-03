/**
 * @description       : Trigger to find Sum of all related Opportunities Amount of an Account.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/


trigger SumOfAllRealatedOppTrigger on Opportunity (after insert, after update, after delete, after undelete) {

    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUndelete)) {
        SumOfAllRealatedOppTriggerHandler.sumOfOpportunity(Trigger.new, null);
        
    } else if (Trigger.isAfter && Trigger.isUpdate) {
        SumOfAllRealatedOppTriggerHandler.sumOfOpportunity(Trigger.new, Trigger.oldMap);
        
    } else if (Trigger.isAfter && Trigger.isDelete) {
        SumOfAllRealatedOppTriggerHandler.sumOfOpportunity( null,Trigger.old);
    }
}
