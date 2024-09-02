/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/

// Q 13 of 60 ----> Prevent duplication of contact record based on Email and Phone

trigger PreventContactDuplication on Contact (before insert, before update) {

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        ContactDuplicationTriggerHandler.preventDuplicateContacts(Trigger.new);
    }

}