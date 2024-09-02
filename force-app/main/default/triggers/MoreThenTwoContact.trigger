/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/
// Q 11) of 60 ----> Trigger to show an Error if there are already two contacts present on an Account and the User tries to add one more.

trigger MoreThenTwoContact on Contact (before insert, before update) {

    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
        MoreThanTwoContactHandler.handleContactTrigger(Trigger.new);
    }

}