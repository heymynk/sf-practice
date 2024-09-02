/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/

// If Opportunity stage is Modified, update Opportunity Amount, based on Probability * Expected Revenue.
trigger OpportunityTriggerCase7 on Opportunity (before update) {

    if(Trigger.isUpdate && Trigger.isBefore){
    OpportunityTriggerCase7Handler.updateAmountCase7(Trigger.new, Trigger.oldMap);
    }
}