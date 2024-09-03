/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/
trigger MaxMinSalaryTrigger on Employee__c (after insert, after update, after delete, after undelete) {

    if(Trigger.isAfter && Trigger.isUpdate){
        MaxMinSalaryTriggerHandler.handelMinMaxSalary(Trigger.new, Trigger.oldMap);
    }else if(Trigger.isAfter && Trigger.isDelete){
        MaxMinSalaryTriggerHandler.handelMinMaxSalary(Trigger.old, null);

    } else {
        MaxMinSalaryTriggerHandler.handelMinMaxSalary(Trigger.new, null);

    }

}