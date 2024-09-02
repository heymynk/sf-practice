/**
 * @description       : Send Email to contacts on Account when Type is changed.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/

trigger SendEmailOnAccountTypeUpdate on Account (after update) {

    if(Trigger.isUpdate && Trigger.isBefore){
        SendEmailOnAccountTypeUpdateHandler.sendEmailOnTypeChange(Trigger.new, Trigger.oldMap);
    }
    
}