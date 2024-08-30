/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/


// Whenever a task is created, set priority to high.
trigger TaskTrigger on Task (before insert) {

    if(trigger.isInsert && trigger.isBefore){
        if (Trigger.isInsert && Trigger.isBefore) {
            TaskTriggerHandler.handleTaskPriority(Trigger.new);
        }
    }
}