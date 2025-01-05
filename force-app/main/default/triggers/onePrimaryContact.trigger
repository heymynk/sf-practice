/**
 * @description       : Ensure One Primary Contact Per Account
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-06-2025
 * @last modified by  : Mayank Singh
**/
trigger onePrimaryContact on Contact (before insert, before update) {


    switch on Trigger.OperationType{
        when BEFORE_INSERT {
            onePrimaryContactHandler.ensureSinglePrimaryContact(Trigger.new, null);
        }
        when BEFORE_UPDATE {
            onePrimaryContactHandler.ensureSinglePrimaryContact(Trigger.new, Trigger.oldMap);
        }
    }
}