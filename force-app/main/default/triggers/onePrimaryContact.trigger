/**
 * @description       : Ensure One Primary Contact Per Account
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-04-2025
 * @last modified by  : Mayank Singh
**/
trigger onePrimaryContact on Contact (before insert, before update) {

    onePrimaryContactHandler handler = new onePrimaryContactHandler();

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        handler.ensureSinglePrimaryContact(Trigger.new, Trigger.oldMap);
    }

}   