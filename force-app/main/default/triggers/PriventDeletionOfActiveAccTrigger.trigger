/**
 * @description       : Prevent users from deleting an Active Account.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/
trigger PriventDeletionOfActiveAccTrigger on Account (before delete) {

    if(Trigger.isBefore && Trigger.isDelete){
        PriventDeletionOfActiveAccHandler.preventActiveAccDeletion(Trigger.old);
    }

}