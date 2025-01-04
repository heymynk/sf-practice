/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 01-04-2025
 * @last modified by  : Mayank Singh
**/
trigger AutoPrimaryContactTrigger on Contact (after insert) {
    AutoPrimaryContactHandler handler = new AutoPrimaryContactHandler();
    handler.setPrimaryContact(Trigger.new);
}
