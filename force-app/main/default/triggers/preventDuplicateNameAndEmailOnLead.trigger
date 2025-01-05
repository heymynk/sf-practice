/**
 * @description       : Prevent duplication of Name and Email on the Lead object.
 * @author            : Mayank Singh
 * @group             :
 * @last modified on  : 01-05-2025
 * @last modified by  : Mayank Singh
 **/
trigger preventDuplicateNameAndEmailOnLead on Lead (before insert, before update) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            PreventDuplicateHandler.beforeInsertHandler(Trigger.new);
        }
        when BEFORE_UPDATE {
            PreventDuplicateHandler.beforeUpdateHandler(Trigger.new, Trigger.oldMap);
        }
    }
}