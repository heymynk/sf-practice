/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/

// Whenever a case is created and the case origin is Phone, set Priority to high otherwise set it low
trigger SetCasePriority on Case (before insert) {
    if(Trigger.isInsert && Trigger.isBefore){

        SetCasePriorityHandler.handleTaskPriority(Trigger.new);
    }

}