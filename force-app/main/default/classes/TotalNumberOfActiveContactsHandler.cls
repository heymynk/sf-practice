/**
 * @description       :
 * @author            : Mayank Singh
 * @group             :
 * @last modified on  : 01-05-2025
 * @last modified by  : Mayank Singh
 **/
public with sharing class TotalNumberOfActiveContactsHandler {
    public static void afterInsertHandler(List<Contact> newContacts){
        Set<Id> uniqueAccIds = new Set<Id>();
        for(Contact  con: newContacts){
            if(String.isNotBlank(con.AccountId)){
                uniqueAccIds.add(con.AccountId);
            }
        }
        AccountContactService.updateActiveContacts(uniqueAccIds);
    }
    
    public static void afterUpdateHandler(List<Contact> newContacts, Map<Id, Contact> oldContactsMap ){
        Set<Id> uniqueAccIds = new Set<Id>();
        for(Contact  con: newContacts){
            if(String.isNotBlank(con.AccountId) && oldContactsMap.get(con.Id).Active__c != con.Active__c){
                uniqueAccIds.add(con.AccountId);
            }else if(oldContactsMap.get(con.Id).AccountId != con.AccountId){
                uniqueAccIds.add(con.AccountId);
                uniqueAccIds.add(oldContactsMap.get(con.Id).AccountId);
            }
        }
        AccountContactService.updateActiveContacts(uniqueAccIds);
    }
    
    public static void afterDeleteHandler(List<Contact> oldConatcst){
        Set<Id> uniqueAccIds = new Set<Id>();
        for(Contact  con: oldConatcst){
            if(String.isNotBlank(con.AccountId)){
                uniqueAccIds.add(con.AccountId);
            }
        }
        AccountContactService.updateActiveContacts(uniqueAccIds);
    }
    
    public static void afterUndeleteHandler(List<Contact> newContacts){
        Set<Id> uniqueAccIds = new Set<Id>();
        for(Contact  con: newContacts){
            if(String.isNotBlank(con.AccountId)){
                uniqueAccIds.add(con.AccountId);
            }
        }
        AccountContactService.updateActiveContacts(uniqueAccIds);
    }
}