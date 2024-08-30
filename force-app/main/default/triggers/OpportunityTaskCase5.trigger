/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/

// Use case 5 --- Whenever an Opportunity is Closed Won, Create a Task for the Opportunity Owner to split the revenue among the team with high priority.


trigger OpportunityTaskCase5 on Opportunity (after update) {
    if(Trigger.isAfter && (Trigger.isUpdate)){
        OpportunityTriggerHandlerCase5.handleOpportunityCase5(Trigger.new);
    }

}