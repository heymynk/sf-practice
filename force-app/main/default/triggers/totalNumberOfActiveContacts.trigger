/**
 * @description       : Contact has a checkbox field called Active__c. Write a trigger that updates the Total_Number_of_Active_Contacts__c field on the Account object with the total number of active contacts associated with that account.
 * @author            : Mayank Singh
 * @group             :
 * @last modified on  : 01-05-2025
 * @last modified by  : Mayank Singh
 **/


trigger totalNumberOfActiveContacts on Contact (after insert, after update, after delete, after undelete) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT{
            TotalNumberOfActiveContactsHandler.afterInsertHandler(Trigger.new);
        }
        when AFTER_UPDATE {
            TotalNumberOfActiveContactsHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        when AFTER_DELETE{
            TotalNumberOfActiveContactsHandler.afterDeleteHandler(Trigger.old);
        }
        when AFTER_UNDELETE{
            TotalNumberOfActiveContactsHandler.afterUndeleteHandler(Trigger.new);
        }
    }
    
}