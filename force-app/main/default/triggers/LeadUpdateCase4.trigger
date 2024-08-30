/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/

// Use Case 4 --- Whenever a Lead is updated and industry is Healthcare, set Lead Source as purchased List, SIC code  to 1100, Primary yes

trigger LeadUpdateCase4 on Lead (before update) {

    if(Trigger.isUpdate && Trigger.isBefore){
        LeadUpdateTriggerHandlerCase4.updateLeadCase4(Trigger.new);
    }
}