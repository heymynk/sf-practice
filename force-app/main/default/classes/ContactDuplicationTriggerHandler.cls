/**
 * @description       : Handler class to prevent Contact duplication based on Email and Phone.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class ContactDuplicationTriggerHandler {
    public static void preventDuplicateContacts(List<Contact> newContacts) {
        System.debug('=== START preventDuplicateContacts ===');
        System.debug('Number of new Contacts: ' + newContacts.size());

        // Step 1: Initialize maps to store unique emails and phones from the new contacts
        Map<String, Contact> emailToContactMap = new Map<String, Contact>();
        Map<String, Contact> phoneToContactMap = new Map<String, Contact>();

        // Step 2: Populate maps with email and phone keys from the incoming contacts
        for (Contact con : newContacts) {
            if (con.Email != null) {
                String emailKey = con.Email.toLowerCase().trim();
                if (!emailToContactMap.containsKey(emailKey)) {
                    emailToContactMap.put(emailKey, con);
                    System.debug('Added to emailToContactMap: ' + emailKey);
                }
            }
            if (con.Phone != null) {
                String phoneKey = con.Phone.trim();
                if (!phoneToContactMap.containsKey(phoneKey)) {
                    phoneToContactMap.put(phoneKey, con);
                    System.debug('Added to phoneToContactMap: ' + phoneKey);
                }
            }
        }

        // Step 3: Query existing contacts in the database with matching email or phone
        List<Contact> duplicates = new List<Contact>();
        if (!emailToContactMap.isEmpty() || !phoneToContactMap.isEmpty()) {
            duplicates = [
                SELECT Id, Name, Email, Phone
                FROM Contact
                WHERE Email IN :emailToContactMap.keySet()
                   OR Phone IN :phoneToContactMap.keySet()
            ];
            System.debug('Number of duplicates found: ' + duplicates.size());
        }

        // Step 4: Check for duplicates and add error messages to prevent saving
        for (Contact dupCon : duplicates) {
            if (dupCon.Email != null) {
                String emailKey = dupCon.Email.toLowerCase().trim();
                System.debug('Checking duplicate for Email: ' + dupCon.Email + ', Key: ' + emailKey);
                if (emailToContactMap.containsKey(emailKey)) {
                    emailToContactMap.get(emailKey).addError('A contact with this email already exists.');
                    System.debug('Duplicate Email found: ' + emailKey);
                }
            }
            if (dupCon.Phone != null) {
                String phoneKey = dupCon.Phone.trim();
                System.debug('Checking duplicate for Phone: ' + dupCon.Phone + ', Key: ' + phoneKey);
                if (phoneToContactMap.containsKey(phoneKey)) {
                    phoneToContactMap.get(phoneKey).addError('A contact with this phone number already exists.');
                    System.debug('Duplicate Phone found: ' + phoneKey);
                }
            }
        }

        System.debug('=== END preventDuplicateContacts ===');
    }
}
