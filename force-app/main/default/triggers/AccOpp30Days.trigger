/**
 * @description       : Write a trigger on the Account when the Account is updated check all opportunities related to the account. Update all opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/


trigger AccOpp30Days on Account (after update) {

    if(Trigger.isAfter && Trigger.isUpdate){
        AccOpp30DaysHandler.handleOppStageUpdate(Trigger.new, Trigger.oldMap);
    }

}