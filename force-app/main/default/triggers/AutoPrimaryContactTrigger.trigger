/**
 * @description       :
 * @author            : Mayank Singh
 * @group             :
 * @last modified on  : 01-06-2025
 * @last modified by  : Mayank Singh
 **/
trigger AutoPrimaryContactTrigger on Contact (after insert) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            AutoPrimaryContactHandler.setPrimaryContact(Trigger.new);
        }
    }
}