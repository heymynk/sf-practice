/**
 * @description       : Update Min and Max fields on TechFirm Object whenever the Employee record is inserted, updated, deleted, undeleted.
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 09-03-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class MaxMinSalaryTriggerHandler {

    // Method to handle Min and Max Salary updates on Tech_Firm__c object
    public static void handelMinMaxSalary(List<Employee__c> empList, Map<Id, Employee__c> oldMap){
        
        // Fetch the ParentId of Tech_Firm__c Object and store it in a set.
        Set<Id> parentIds = new Set<Id>();

        if(!empList.isEmpty()){  
            for(Employee__c newEmp : empList){
                // Check if this is an update operation by verifying if oldMap is not null
                if(oldMap != null){
                    Employee__c oldEmp = oldMap.get(newEmp.Id);

                    // Check if the Parent record of the child record has changed (i.e., Tech_Firm__c has been updated)
                    if(oldEmp.Tech_Firm__c != newEmp.Tech_Firm__c){
                        // Add the old Parent Tech_Firm__c Id to the set (for handling old Parent record)
                        parentIds.add(oldEmp.Tech_Firm__c);
                        // Add the new Parent Tech_Firm__c Id to the set (for handling new Parent record)
                        parentIds.add(newEmp.Tech_Firm__c);
                    } else {
                        // If the Parent Tech_Firm__c is the same, just add the new Parent Id to the set
                        parentIds.add(newEmp.Tech_Firm__c);
                    }
                } else {
                    // When a new record is inserted (no oldMap available)
                    parentIds.add(newEmp.Tech_Firm__c);
                }
            }
        }

        // Aggregate the max and min salary for each Tech_Firm__c
        List<AggregateResult> aggList = [
            SELECT Tech_Firm__c tfId, MAX(Salary__c) maxSalary, MIN(Salary__c) minSalary 
            FROM Employee__c 
            WHERE Tech_Firm__c IN :parentIds 
            GROUP BY Tech_Firm__c
        ];

        Map<Id, Tech_Firm__c> mapToUpdate = new Map<Id, Tech_Firm__c>();
        if(!aggList.isEmpty()){
            for(AggregateResult aggr : aggList){
                Id techFirmId = (Id) aggr.get('tfId');
                System.debug('Tech Firm Id: ' + techFirmId);
                if (techFirmId != null) {
                    Tech_Firm__c tf = new Tech_Firm__c();
                    tf.Id = techFirmId;
                    tf.MaxSalary__c = (Decimal) aggr.get('maxSalary');
                    tf.MinSalary__c = (Decimal) aggr.get('minSalary');
                    mapToUpdate.put(tf.Id, tf);
                } else {
                    System.debug('Skipping update due to null Tech Firm Id');
                }
            }
        }

        if(!mapToUpdate.isEmpty()){
            update mapToUpdate.values();
        }
    }
}
