/**
 * @description       : Trigger to update the account field when opportunity is updated
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-10-2024
 * @last modified by  : Mayank Singh
**/

trigger OpportunityUpdateTrigger on Opportunity (after update) {

    if(Trigger.isAfter && Trigger.isUpdate){

        OpportunityUpdateHandler.updateAccount(Trigger.new, Trigger.oldMap);
    }

}