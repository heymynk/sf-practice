/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class LeadTriggerCase6Handler {

    public static void checkClosedLostReason(List<Lead> newLeads){

        List<Task> taskToBeCreated = new List<Task>();


        if(!newLeads.isEmpty()){
            for(Lead leadRec : newLeads){

                Task taskRec = new Task();
                taskRec.ownerId = leadRec.OwnerId;
                taskRec.Subject = 'Fllow Up with the customer';

                taskToBeCreated.add(taskRec);
            }
        }

        if(!taskToBeCreated.isEmpty()){
            insert taskToBeCreated;
        }
    }
}