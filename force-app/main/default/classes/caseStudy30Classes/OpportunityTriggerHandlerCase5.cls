/**
 * @description       : 
 * @author            : Mayank Singh
 * @group             : 
 * @last modified on  : 08-30-2024
 * @last modified by  : Mayank Singh
**/
public with sharing class OpportunityTriggerHandlerCase5 {
    public static void handleOpportunityCase5(List<Opportunity> newOpp){

        //List to store the task to be inserted

        List<Task> tasksToCreate = new List<Task>();

        for(Opportunity op : newOpp){
            if(op.StageName == 'Closed Won'){
                Task taskRec = new Task();
                taskRec.OwnerId = op.OwnerId;
                taskRec.Subject = 'Follow up Closed Won';
                taskRec.Status = 'Not Started';
                taskRec.Priority = 'High';

                tasksToCreate.add(taskRec);
            }
        }

        if(!tasksToCreate.isEmpty()){
            insert tasksToCreate;
            System.debug('Task ceated successfully');
        }
    }
}