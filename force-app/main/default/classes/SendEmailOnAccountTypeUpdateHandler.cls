/**
 * @description       : Send Email to contacts on Account when Type is changed.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-02-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class SendEmailOnAccountTypeUpdateHandler {
    public static void sendEmailOnTypeChange(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
        System.debug('=== START sendEmailOnTypeChange ===');
        System.debug('Number of new Accounts: ' + newAccounts.size());

        // Step 1: Fetch the Parent AccountIds where the Type is changed
        Set<Id> accountIds = new Set<Id>();
        if (!newAccounts.isEmpty()) {
            for (Account acc : newAccounts) {
                Account oldAcc = oldAccounts.get(acc.Id);
                if (oldAcc != null && acc.Type != oldAcc.Type) {
                    accountIds.add(acc.Id);
                    System.debug('Type changed for AccountId: ' + acc.Id);
                }
            }
        }

        // Step 2: Fetch the related Contacts of the Accounts with Type changed
        List<Contact> relatedContacts = [SELECT Id, Email, LastName, AccountId FROM Contact WHERE AccountId IN :accountIds];
        System.debug('Number of related Contacts: ' + relatedContacts.size());

        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        if (!relatedContacts.isEmpty()) {
            for (Contact con : relatedContacts) {
                if (con.Email != null) {
                    // Step 3: Prepare and send Email to Contacts
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTargetObjectId(con.Id);
                    mail.setSenderDisplayName('System Admin');
                    mail.setSubject('Account Update Info');

                    String body = 'Dear ' + con.LastName + ',<br/>';
                    body += 'The Account related to you has been updated. Please check the update.<br/>';
                    mail.setHtmlBody(body);
                    mail.setToAddresses(new String[] {con.Email});
                    emailList.add(mail);
                    System.debug('Prepared email for Contact: ' + con.Id + ', Email: ' + con.Email);
                }
            }
        }

        // Step 4: Send the emails
        if (!emailList.isEmpty()) {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
            System.debug('Number of emails sent: ' + results.size());
            for (Messaging.SendEmailResult result : results) {
                if (result.isSuccess()) {
                    System.debug('Email sent successfully.');
                } else {
                    System.debug('Email failed to send. Errors: ' + result.getErrors());
                }
            }
        }

        System.debug('=== END sendEmailOnTypeChange ===');
    }
}
