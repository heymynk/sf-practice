/**
 * @description       : Trigger to update the account field when opportunity is updated
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-04-2025
 * @last modified by  : Mayank Singh
**/

trigger OpportunityUpdateTrigger on Opportunity (after update) {

    if(Trigger.isAfter && Trigger.isUpdate){

        OpportunityUpdateHandler.updateOpportunities(Trigger.new, Trigger.oldMap);
    }

}