/**
 * @description       : Handler class to prevent duplication of Email and Phone on the Lead object.
 * @author            : Mayank Singh
 * @group             :
 * @last modified on  : 01-05-2025
 * @last modified by  : Mayank Singh
 **/
public with sharing class PreventDuplicateHandler {

    public static void beforeInsertHandler(List<Lead> newLeads) {
        preventDuplicateLeads(newLeads, null);
    }

    public static void beforeUpdateHandler(List<Lead> newLeads, Map<Id, Lead> oldLeads) {
        preventDuplicateLeads(newLeads, oldLeads);
    }

    private static void preventDuplicateLeads(List<Lead> newLeads, Map<Id, Lead> oldLeads) {
        // Collect unique emails and phone numbers
        Set<String> emails = new Set<String>();
        Set<String> phones = new Set<String>();

        for (Lead lead : newLeads) {
            if (String.isNotBlank(lead.Email)) {
                emails.add(lead.Email.toLowerCase());
            }
            if (String.isNotBlank(lead.Phone)) {
                phones.add(lead.Phone);
            }
        }

        // Query existing Leads for duplicates
        Map<String, Id> existingLeadsMap = new Map<String, Id>();
        for (Lead existingLead : [
            SELECT Id, Email, Phone
            FROM Lead
            WHERE Email IN :emails OR Phone IN :phones
        ]) {
            if (String.isNotBlank(existingLead.Email)) {
                existingLeadsMap.put(existingLead.Email.toLowerCase(), existingLead.Id);
            }
            if (String.isNotBlank(existingLead.Phone)) {
                existingLeadsMap.put(existingLead.Phone, existingLead.Id);
            }
        }

        // Prevent duplicates in new Leads
        for (Lead newLead : newLeads) {
            if (String.isNotBlank(newLead.Email) && existingLeadsMap.containsKey(newLead.Email.toLowerCase())) {
                newLead.addError('A Lead with this email already exists.');
            }

            if (String.isNotBlank(newLead.Phone) && existingLeadsMap.containsKey(newLead.Phone)) {
                newLead.addError('A Lead with this phone number already exists.');
            }
        }
    }
}